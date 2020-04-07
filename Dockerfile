ARG RUBY_VERSION=2.6
ARG ALPINE_VERSION=3.10

# Defines base image which builder and final stage use
FROM ruby:$RUBY_VERSION-alpine$ALPINE_VERSION as base

# Change this is Gemfile.lock bundler version changes
ARG BUNDLER_VERSION=2.1.4

WORKDIR /usr/src/app
RUN apk add --update \
  build-base \
  nodejs \
  tzdata \
  yarn \
  && rm -rf /var/cache/apk/* \
  && gem install bundler:$BUNDLER_VERSION \
  && bundle config --global frozen 1

# Pulls in private dependencies, which can be used in the next stage,
FROM base as builder

COPY . .
RUN bundle install --without="development test"
RUN yarn install
RUN RAILS_ENV=${RAILS_ENV} rake assets:precompile

# We don't need this at runtime, once the precompiled assets are built
RUN rm -rf node_modules

# Final build step
FROM base

RUN addgroup -S app && adduser -S -G app app
ENV RAILS_SERVE_STATIC_FILES=true
ENV RAILS_LOG_TO_STDOUT=true
ENV RAILS_RELATIVE_URL_ROOT='/'
EXPOSE 3000

WORKDIR /usr/src/app

COPY --from=builder --chown=app /usr/src/app /usr/src/app
COPY --from=builder --chown=app /usr/local/bundle /usr/local/bundle

COPY entrypoint.sh ./
RUN chmod 755 /usr/src/app/entrypoint.sh
RUN RAILS_SERVE_STATIC_FILES=true rails assets:precompile

USER app

# CMD ./bin/rails test
# CMD ./bin/rails server -e ${RAILS_ENV} -b 0.0.0.0
ENTRYPOINT /usr/src/app/entrypoint.sh

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
RUN bundle install --without="development" \
  && yarn install \
  && RAILS_ENV=production rake assets:precompile \
  && mkdir -p 777 /usr/src/app/coverage \
  && rm -rf node_modules

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

USER app

ENTRYPOINT /usr/src/app/entrypoint.sh

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
  && rm -rf /var/cache/apk/* \
  && gem install bundler:$BUNDLER_VERSION \
  && bundle config --global frozen 1

# Pulls in private dependencies, which can be used in the next stage,
# without storing private key in history
FROM base as builder

COPY Gemfile Gemfile.lock package.json yarn.lock ./
RUN bundle install
COPY . .

# Final build step
FROM base

RUN addgroup -S app && adduser -S -G app app
ENV RAILS_SERVE_STATIC_FILES=true
ENV RAILS_LOG_TO_STDOUT=true
EXPOSE 3000

WORKDIR /usr/src/app

COPY --from=builder --chown=app /usr/src/app /usr/src/app
COPY --from=builder --chown=app /usr/local/bundle /usr/local/bundle

USER app

# CMD ./bin/rails test
CMD ./bin/rails server -e $RAILS_ENV -b 0.0.0.0

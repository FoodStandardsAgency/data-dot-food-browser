# Data.food data catalog browser

This project provides the user-interface for users to browse and
download the data catalogue on `data.food.gov.uk`. Each catalogue
entry is a `dataset`, and each dataset has one or more `elements`.
Elements are subsets of the dataset by some theme, for example
returns from a local authority, or figures from a particular period
in time.

The data catalog is a Ruby on Rails application. At the moment, there
is no interactive JavaScript on the pages, apart from the cookie
manager.

## Installing the application

First clone the `data-catalog-browser` repo, then `bundle install` the
gem dependencies.

## Running the API

The data for the application comes from a data catalogue API (which is a
SAPI app). In production, the app will run with the production API. In
development, we generally use the staging API to obtain data for the app
to display. The application expects the API to be running on `localhost:8080`.
The script `bin/sr-tunnel-daemon` wraps a simple ssh command to proxy
the staging API to `localhost`.

To get the proxy running, you will need the appropriate ssh configuration.
Into `~/.ssh/config` add:

    Host fsa-staging-catalog
      HostName fsa-staging-catalog.epimorphics.net
      User ubuntu
      IdentityFile ~/.ssh/fsa.pem

This assumes you have the FSA server credentials locally as `fsa.pem`. If you
do not have the .pem file installed, look in S3:

    aws --profile epimorphics s3 ls s3://epi-ops/keys/

(the `profile` may be different, depending what you have in `~/.aws/credentials`)

## Running the application

Once the API is running as `localhost:8080`, start the Rails app in the usual way:

    rails server

## Running the tests

TODO

## Code standards

TODO

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
to display.

We are in the process of changing how the app sees the API, in preparation
for putting the app into a Docker container for deployment. In future,
the location of the URL that the app will use to access the API will be
passed as an environment variable: `FSA_DATA_DOT_FOOD_API_URL`.
Behaviour equivalent to the current architecture, in which the app expects
the API to be mapped to `localhost:8080` can be achieved by (i) mapping
the API to local host, and (ii) setting `FSA_DATA_DOT_FOOD_API_URL`
to `localhost:8080`.

Otherwise, we have amended the security group on the back-end query service
to allow access from a fixed range of IP addresses, including the
Epimorphics office. So, assuming the IP address does not change, the
dev API can be accessed via:

```sh
FSA_DATA_DOT_FOOD_API_URL=http://18.202.57.165:8080
```

### Notes on accessing the API via SSH tunnel (deprecated)

Note: deprecated. This method is kept for transitional reasons only.
In future, we will rely on accessing the API via a URL passed through
the environment.

The application expects the API to be running on `localhost:8080`.
The script `bin/sr-tunnel-daemon` wraps a simple ssh command to proxy
the staging API to `localhost`.

To get the proxy running, you will need the appropriate ssh configuration.
Into `~/.ssh/config` add:

```text
Host fsa-staging-catalog
    HostName fsa-staging-catalog.epimorphics.net
    User ubuntu
    IdentityFile ~/.ssh/fsa.pem
```

This assumes you have the FSA server credentials locally as `fsa.pem`. If you
do not have the .pem file installed, look in S3:

```sh
aws --profile epimorphics s3 ls s3://epi-ops/keys/
```

(the `profile` may be different, depending what you have in `~/.aws/credentials`)

## Running the application

Set the location of the API URL in the environment, then
start the Rails app in the usual way:

```sh
FSA_DATA_DOT_FOOD_API_URL=http://18.202.57.165:8080 rails server
```

## Running the tests

The unit tests are run with `rails test`:

```sh
FSA_DATA_DOT_FOOD_API_URL=http://18.202.57.165:8080 rails test
```

Interactions with the API are recorded as VCR cassettes, which are
automatically renewed periodically. To force the tests to exercise
the API, first remove the existing cassettes:

```sh
rm test/vcr_cassettes/*
FSA_DATA_DOT_FOOD_API_URL=http://18.202.57.165:8080 rails test
```

## Running as a Docker container

The app is configured to be able to be run as a Docker container. For
convenience, a collection of `make` targets are provided. You may need
to install make itself. On Ubuntu, for example:

```sh
sudo apt install make
```

The available make targets include:

- `image` - creates a new Docker image, labelled with the image name and
  tagged with the current app version
- `prod` - runs the curent Docker image in a local container, but in production
  mode. This simulates how the app would run in a production deployment
- `version` - reveals the current appliation version
- `test` - runs the Rails tests on the app running in a container
- `clean` - removes temporary build artefacts, such as webpacked assets
- `release` - push the container to a registry

For example, to ensure the image is up-to-date and then run the app
locally but in production mode:

```sh
$ make clean prod
I, [2020-05-14T13:31:25.009548 6572]  INFO -- : Removed data-dot-food-browser/public/assets
Removed webpack output path directory data-dot-food-browser/public/packs
docker build --tag data-dot-food-browser:1.1.0 .
Sending build context to Docker daemon  7.222MB
Step 1/22 : ARG RUBY_VERSION=2.6
...
Successfully tagged data-dot-food-browser:1.1.0
docker run --rm --name data-dot-food-browser -p3000:3000 -e RAILS_ENV=production ...
```

## Code standards

Running `rubocop` and `eslint app/javascript` should report no errors.

`rails test` should run with no errors and without extraneous console output.

`TODO`s should be replaced by tickets.

Deprecation warnings from Rails should be resolved as soon as possible.

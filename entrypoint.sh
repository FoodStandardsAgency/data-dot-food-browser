#! /bin/sh

if [ -z "$FSA_DATA_DOT_FOOD_API_URL" ]
then
  echo "Environment Variable \$FSA_DATA_DOT_FOOD_API_URL not defined." >&2
  exit 1
fi

if [ -z "$RAILS_ENV" ] # We could default this but I'm unsure which way would be better
then
  echo "Environment Variable \$RAILS_ENV not defined." >&2
  exit 1
fi

if [ "$RAILS_ENV" == "production" ] && [ -z "$SECRET_KEY_BASE" ]
then 
  echo "Setting environment variable \$SECRET_KEY_BASE."
  export SECRET_KEY_BASE=`./bin/rails secret`
fi

exec ./bin/rails server -e ${RAILS_ENV} -b 0.0.0.0

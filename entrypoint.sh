#! /bin/sh

if [ -z "$FSA_DATA_DOT_FOOD_API_URL" ]
then
  echo "Environment Variable \$FSA_DATA_DOT_FOOD_API_URL not defined." >&2
  exit 1
fi

if [ -z "$RAILS_ENV" ]
then
  echo "Environment Variable \$RAILS_ENV not defined." >&2
  exit 1
fi

if [ "$RAILS_ENV" == "production" ] && [ -z "$SECRET_KEY_BASE" ]
then 
  echo "Environment Variable \$SECRET_KEY_BASE not defined." >&2
fi

exec ./bin/rails server -e ${RAILS_ENV} -b 0.0.0.0

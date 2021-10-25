#!/bin/bash

LOCAL_DATABASE_URL=$DATABASE_URL
PRODUCTION_DATABASE_URL=`heroku config:get DATABASE_URL -a $HEROKU_PRODUCTION_APPLICATION_NAME`
pg_dump -a -d  $PRODUCTION_DATABASE_URL > hoge.sql
bundle exec rails db:schema:load
psql -d $LOCAL_DATABASE_URL/walker_development -f hoge.sql
rm hoge.sql

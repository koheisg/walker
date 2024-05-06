release: bin/rails db:migrate
web: bin/rails server -p $PORT -e $RAILS_ENV
worker: bin/rails rake solid_queue:start

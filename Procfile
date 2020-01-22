web: bundle exec rails server -p $PORT -e $RACK_ENV
worker: bundle exec sidekiq -e $RACK_ENV -C config/sidekiq.yml
release: bundle exec rails db:migrate

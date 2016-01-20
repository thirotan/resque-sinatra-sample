TERM_CHILD=1 QUEUE=default rake resque:work &
RACK_ENV=production bundle exec rackup config.ru -p 9292

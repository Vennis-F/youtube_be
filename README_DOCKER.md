### restore dump file

docker cp ~/Downloads/dev.dump postgres:/tmp/dev.dump

docker exec -it postgres bash

pg_restore --verbose --clean --no-acl --no-owner -U postgres -d youtube_db_development /tmp/dev.dump

#### run app( same as command: rails s)

docker-compose up

#### create migration

docker-compose run web rails g migration "AddColumnXXXToTable"

#### run migrate

docker-compose run web rails db:migrate

#### run rake task

docker compose run web rails "auto:xxxxxx"

#### run rails c

docker compose run web rails c

#### check puma logs when app running

docker-compose logs -f

#### run mqtt client

docker compose run web ruby "exec/mqtt_service.rb"

##### check service mqtt run or not after run mqtt client

ps aux | grep mqtt

#### run sidekiq server

docker compose run web bundle exec sidekiq

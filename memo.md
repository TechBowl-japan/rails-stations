#メモ
docker compose run --rm web bundle install
docker compose exec web rails console
docker compose run --rm web rails db:migrate
docker compose run --rm web rails routes
docker compose restart

Railwayに取り組むときは
docker compose up -d
やめる時は
docker compose down
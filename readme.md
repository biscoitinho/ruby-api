> Simple game collection API written in Ruby with Sinatra, ActiveRecord and Sqlite3


`bundle install`

To add a new one:

`curl -i -X POST -H "Content-Type: application/json" -d '{"name":"GameName", "genre":"GameGenre"}' http://localhost:4567/api/v1/game`

To update one:

`curl -i -X PATCH -H "Content-Type: application/json" -d '{"name":"GameName", "genre":"GameGenre"}' http://localhost:4567/api/v1/games/IdGame`

To delete one:

`curl -i -X DELETE -H "Content-Type: application/json" http://localhost:4567/api/v1/games/IdGame`


Inspired by a blog post at:
[x-team.com](http://x-team.com/2016/04/how-to-create-a-ruby-api-with-sinatra/)

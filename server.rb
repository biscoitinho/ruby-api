require 'sinatra'
require 'sinatra/namespace'
require 'active_record'
require 'sqlite3'
require_relative './models/game.rb'
require_relative './config/database.rb'
require_relative './serializers/game_serializer.rb'


namespace '/api/v1' do

  before do
    content_type 'application/json'
  end

  helpers do
    def base_url
      @base_url ||= "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
    end

    def json_params
      begin
        JSON.parse(request.body.read)
      rescue
        halt 400, { message: 'Invalid JSON' }.to_json
      end
    end

    def error_log
       @error =  { message: 'Error' }.to_json
    end

    def game
      @game ||= Game.where(id: params[:id]).first
    end

    def halt_if_not_found!
      halt(404, { message: 'Game Not Found'}.to_json) unless game
    end

    def serialize(game)
      GameSerializer.new(game).to_json
    end
  end

  get '/games' do
    games = Game.all
    games = games.where(name: params["name"]) if params["name"]
    games.map { |game| GameSerializer.new(game) }.to_json
  end

  get '/games/:id' do |id|
    halt_if_not_found!
    serialize(game)
  end

  post '/game' do
    game = Game.new(json_params)
    halt 422, serialize(game) unless game.save

    response.headers['Location'] = "#{base_url}/api/v1/games/#{game.id}"
    status 201
  end

  patch '/games/:id' do |id|
    halt_if_not_found!
    halt 422, serialize(game) unless game.update_attributes(json_params)
    serialize(game)
  end

  delete '/games/:id' do |id|
    game.destroy if game
    status 204
  end
end

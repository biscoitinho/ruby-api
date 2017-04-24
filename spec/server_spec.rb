require 'spec_helper'

RSpec.describe 'games API' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe "/api/v1/games" do
    it "returns 200" do
      get '/api/v1/games'
      expect(last_response.status).to eq(200)
    end

    it "returns json content" do
      get '/api/v1/games'
      expect(last_response.content_type).to eq("application/json")
    end

    it "returns 404 error when wrong path provided" do
      get '/games'
      expect(last_response.status).to eq(404)
    end

    it "adds a new game" do
      game_params = {
          "name" => "tetris",
          "genre" => "logical"
      }.to_json

      request_headers = {
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      }

      post "/api/v1/game", game_params, request_headers

      expect(last_response.status).to eq 201
      expect(Game.last.name).to eq "tetris"
    end
  end
end

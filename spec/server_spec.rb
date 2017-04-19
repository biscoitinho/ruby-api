require_relative '../server.rb'
require 'rack/test'

RSpec.describe 'games API' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe "/games" do
    it "returns 200" do
      get '/api/v1/games'
      expect(last_response.status).to eq(200)
    end
  end
end

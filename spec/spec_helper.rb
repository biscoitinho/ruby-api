ENV['RACK_ENV'] = 'test'

require_relative '../server.rb'
require 'rack/test'
require 'database_cleaner'

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end
  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end
  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end
end

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database =>  './db/api_test.db'
)

unless ActiveRecord::Base.connection.data_source_exists?(:games)
  ActiveRecord::Base.connection.create_table :games do |t|
    t.string :name
    t.string :genre
  end
end

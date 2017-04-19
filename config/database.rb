ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database =>  './db/api.db'
)

unless ActiveRecord::Base.connection.data_source_exists?(:games)
  ActiveRecord::Base.connection.create_table :games do |t|
    t.string :name
    t.string :genre
  end
end

require 'data_mapper'

env = ENV["RACK_ENV"] || "development"
# use for heroku deployment 
#  DataMapper.setup(:default, ENV["DATABASE_URL"]) 
DataMapper.setup(:default, "postgres://localhost/schitter_#{env}") 

Dir.glob(File.join(File.dirname(__FILE__), 'models', '*.rb'), &method(:require))

DataMapper.finalize

DataMapper.auto_upgrade!

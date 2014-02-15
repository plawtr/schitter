require 'data_mapper'

env = ENV["RACK_ENV"] || "development"
DataMapper.setup(:default, ENV["DATABASE_URL"]) 

Dir.glob(File.join(File.dirname(__FILE__), 'models', '*.rb'), &method(:require))

DataMapper.finalize

DataMapper.auto_upgrade!

require 'data_mapper'
require './app/server'

task :autoupgrade do 
	DataMapper.auto_upgrade!
	puts "Auto-upgrade complete (no data loss)"
end

task :automigrate do 
	DataMapper.auto_migrate!
	puts "Auto-migrate complete (data loss possible)"
end

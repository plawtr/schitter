require 'sinatra/base'

require_relative 'server'

require_relative './controllers/base'
Dir.glob(File.join(File.dirname(__FILE__), 'controllers', '*.rb'), &method(:require))


class Schitter < Sinatra::Base
  # get '/' do
  #   'Hello Schitter!'
  # end

  use Controllers::Schits
  use Controllers::Users
  use Controllers::Authentication

  # start the server if ruby file executed directly
  run! if app_file == $0
end

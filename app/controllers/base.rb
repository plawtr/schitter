require 'rack-flash'
require 'sinatra/partial'

require_relative '../helpers/application'

module Controllers
  class Base < Sinatra::Base

  	enable :sessions
  	set :session_secret, "Twitter sucks!"
  	
  	register Sinatra::Partial

  	use Rack::Flash
  	use Rack::MethodOverride

    helpers ServerHelper

		set :partial_template_engine, :erb

  	set :views, File.join(File.dirname(__FILE__), '../views')
#  	set :public, File.join(File.dirname(__FILE__), '../public')

  end
end






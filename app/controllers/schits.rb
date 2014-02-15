module Controllers
	class Schits < Base
	  get '/' do
	  	@schits = Schit.all(:order => [ :time_stamp.desc ])
	    erb :index
	  end

	  get '/schits/new' do
	  	if current_user
		  	erb :"schits/new"
	  	else
	  		erb :"sessions/new"
	  	end

	  end

	  post '/schits' do
	  	message = params["message"]
			Schit.create(:message => message, :time_stamp => Time.now, :user => current_user)
	  	redirect to('/')	
	  end
	end
end


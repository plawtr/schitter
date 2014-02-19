module Controllers
	class Schits < Base
	  get '/' do
	  	@schits = Schit.all(:order => [ :time_stamp.desc ])
	    erb :index, :layout => !request.xhr? 
	  end

	  get '/schits/new' do
	  	if current_user
		  	erb :"schits/new", :layout => !request.xhr? 
	  	else
	  		erb :"sessions/new", :layout => !request.xhr?
	  	end

	  end

	  post '/schits' do
	  	message = params["message"]
			schit = Schit.create(:message => message, :time_stamp => Time.now, :user => current_user)
	  	if request.xhr?
				erb :schit, :locals => {:schit => schit}, :layout => false
			else
				redirect to('/')
			end
		end
	end
end


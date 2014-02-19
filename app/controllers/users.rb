 module Controllers
  class Users < Base 
    get '/users/new' do
    	@user = User.new
    	erb :"users/new", :layout => !request.xhr? 
    end

    post '/users' do
    	@user = User.new(:email => params[:email],
                      :name => params[:name],
                      :user_name => params[:user_name],
    									:password => params[:password],
    									:password_confirmation => params[:password_confirmation])
    	if @user.save
  	  	session[:user_id] = @user.id
  	  	redirect to('/')
  	  else
  	  	flash.now[:errors] = @user.errors.full_messages
  	  	erb :"users/new", :layout => !request.xhr?  
  	  end
    end

    get "/users/reset_password/:token" do
    	@user = User.first(:password_token => params[:token])
    	if @user && (Time.now-Time.parse(@user.password_token_timestamp))<3600
    		erb :"users/new_password"
    	else
  	  	flash[:notice] = "This password reset url does not exist or has expired."
  	  	redirect to '/'  		
    	end
    end
    
    post "/users/reset_password" do
      @user = User.first(:password_token => params[:token])
      @user.password = params[:password]
      @user.password_confirmation = params[:password_confirmation]
      @user.password_token = nil
      @user.password_token_timestamp = nil

      if @user.save
        session[:user_id] = @user.id
        flash[:notice] = "Password updated."
        redirect to('/')
      else
        flash[:errors] = @user.errors.full_messages
        redirect to "/users/reset_password/"+params[:token]
      end
    end


  end
end



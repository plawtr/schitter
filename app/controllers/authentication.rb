module Controllers
	class Authentication < Base

	  get '/sessions/new' do
	  	erb :"sessions/new", :layout => !request.xhr? 
	  end

	  post '/sessions' do
	  	email, password = params[:email], params[:password]
	  	user = User.authenticate(email, password)
	  	if user 
	  		session[:user_id] = user.id
	  		redirect to '/'
	  	else
	  		flash[:errors] = ["The email or password are incorrect"]
	  		erb :"sessions/new", :layout => !request.xhr? 
	  	end
	  end

	  delete '/sessions' do 
	  	flash[:notice] = 'Good bye!'
	  	session[:user_id] = nil
	  	redirect to('/')
	  end

	  get '/sessions/forgot_password' do
	  	erb :"sessions/forgot_password"
	  end

	  post '/sessions/forgot_password' do
	  	email = params[:email]
	  	user = User.first(:email => email)
	  	if user 
		  	user.password_token = (1..64).map{('A'..'Z').to_a.sample}.join
		  	user.password_token_timestamp = Time.now
		  	user.save
		  	# send_message(email, user.password_token)
		  	flash[:notice] = "Temporary password sent to #{email}. Visit: /users/reset_password/#{user.password_token} . Time: #{user.password_token_timestamp}"
		  	redirect to '/'
		  else
		  	flash[:notice] = "Cannot find #{email}, sorry."
		  	erb :"sessions/forgot_password"
		  end
	  end
	end
end

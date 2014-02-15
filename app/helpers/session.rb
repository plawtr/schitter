module SessionHelpers

	def sign_up(email = "alice@example.com", password = "oranges!", password_confirmation = "oranges!", name = "Alice Johnson", user_name= "ajonhson")
		visit '/users/new'
		fill_in :email, :with => email
		fill_in :name, :with => name
		fill_in :user_name, :with => user_name
		fill_in :password, :with => password
		fill_in :password_confirmation, :with => password_confirmation
		click_button "Sign up"
	end
	
	def sign_in(email, password)
		visit '/sessions/new'
		fill_in 'email', :with => email
		fill_in 'password', :with => password
		click_button 'Sign in'
	end

	def password_recovery(email, old_password, new_password)
		sign_up(email, old_password)
		sign_in(email, old_password)
		click_button "Sign out"
		visit('/sessions/forgot_password')
		fill_in 'email', :with => email
		click_button 'Submit'
		user = User.first(:email => email)
		visit "/users/reset_password/#{user.password_token}"
		fill_in 'password', :with => new_password	
	end

end
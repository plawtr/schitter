require 'spec_helper'
require_relative '../../app/helpers/session'
include SessionHelpers


feature "User signs up" do
	scenario "when being logged out" do
		lambda {sign_up}.should change(User, :count).by(1)
		expect(page).to have_content("Welcome, alice@example.com")
		expect(User.first.email).to eq("alice@example.com")
	end

	scenario "with a password that doesn't match" do
		lambda {sign_up('a@a.com', 'pass', 'wrong')}.should change(User, :count).by(0)
		expect(current_path).to eq('/users')
		expect(page).to have_content("Password does not match the confirmation")
	end

	scenario "with an email that is already registered" do
		lambda {sign_up}.should change(User, :count).by(1)
		lambda {sign_up}.should change(User, :count).by(0)
		expect(page).to have_content("This email is already taken")
	end

	scenario "with an username that is already registered" do
		lambda {sign_up}.should change(User, :count).by(1)
		lambda {sign_up("test@example.com", password = "oranges!", password_confirmation = "oranges!", name = "Alice Johnson", user_name= "ajonhson")}.should change(User, :count).by(0)
		expect(page).to have_content("This user name is already taken")
	end

end

feature "User signs in" do

	before(:each) do
		User.create(:email => "test@test.com",
								:name => "Testname Testlastname",
								:user_name => "testusername",
								:password => 'test',
								:password_confirmation => 'test')
	end

	scenario "with correct credentials" do
		visit '/'
		expect(page).not_to have_content("Welcome, test@test.com")
		sign_in('test@test.com', 'test')

		expect(page).to have_content("Welcome, test@test.com")
	end

	scenario "with incorrect credentials" do
		visit '/'
		expect(page).not_to have_content("Welcome, test@test.com")
		sign_in('test@test.com', 'wrong')
		expect(page).not_to have_content("Welcome, test@test.com")
	end

end

feature 'User signs out' do

	before(:each) do
		User.create(:email => "test@test.com",
								:name => "Testname Testlastname",
								:user_name => "testusername",
								:password => 'test',
								:password_confirmation => 'test')
	end

	scenario 'while being signed in' do
		sign_in('test@test.com', 'test')
		click_button "Sign out"
		expect(page).to have_content("Good bye!")
		expect(page).not_to have_content("Welcome, test@test.com")
	end
end

feature "User forgets the password" do
	before(:each) do
		User.create(:email => "test@test.com",
								:name => "Testname Testlastname",
								:user_name => "testusername",
								:password => 'test',
								:password_confirmation => 'test')
	end

	scenario "while already signed up and requests a password recovery token" do
		sign_up('test@test.com', 'test')
		sign_in('test@test.com', 'test')
		click_button "Sign out"
		visit('/sessions/forgot_password')
		fill_in 'email', :with => "test@test.com"
		click_button 'Submit'
		expect(page).to have_content("Temporary password sent to test@test.com.")
	end

	scenario "while not signed up and requests a password recovery token" do
		sign_up('test@test.com', 'test')
				sign_in('test@test.com', 'test')
		click_button "Sign out"
		visit('/sessions/forgot_password')
		fill_in 'email', :with => "wrong@test.com"
		click_button 'Submit'
		expect(page).to have_content("Cannot find wrong@test.com, sorry.")
	end

	scenario "while already signed up and uses a password recovery token giving a new password" do
		password_recovery('test@test.com', 'test', 'new_password')
		fill_in :password_confirmation, :with =>"new_password"
		click_button "Update"
		user = User.first(:email => 'test@test.com')
		expect(page).to have_content("Password updated.")
		expect(user.password_token).to be_nil
		expect(user.password_token_timestamp).to be_nil
		expect(User.authenticate('test@test.com', "new_password")).to be_true
	end

	scenario "while already signed up and uses a password recovery token giving a new password and a wrong confirmation" do
		password_recovery('test@test.com', 'test', 'new_password')
		fill_in :password_confirmation, :with =>"wrong_password"
		click_button "Update"
		expect(page).not_to have_content("Password updated.")
		expect(User.authenticate('test@test.com', "new_password")).to be_false
		fill_in :password_confirmation, :with =>"wrong_password"
		click_button "Update"
		expect(page).to have_content("Password updated.")
	end

end



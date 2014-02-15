require 'spec_helper'

feature "User browses the list of schits" do

	before(:each) {

		user = User.create(:email => "test@test.com",
								:name => "Testname Testlastname",
								:user_name => "testusername",
								:password => 'test',
								:password_confirmation => 'test')

		Schit.create(:time_stamp => Time.now, 
								:message => "Hello World!",
								:user => user )
	}

	scenario "when opening the home page" do
		visit '/'
		expect(page).to have_content("Hello World!")
	end
	
end
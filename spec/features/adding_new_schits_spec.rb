require 'spec_helper'
require_relative '../../app/helpers/session'
include SessionHelpers

feature "User adds a new schit" do 

	before(:each) do
		User.create(:email => "test@test.com",
								:name => "Testname Testlastname",
								:user_name => "testusername",
								:password => 'test',
								:password_confirmation => 'test')
	end

	scenario "when browsing the homepage and not signed in" do
		expect(Schit.count).to eq(0)
		visit "/schits/new"
		expect(page).to have_content("Please sign in")
	end

	scenario "when browsing the homepage and signed in" do
		expect(Schit.count).to eq(0)
		sign_in('test@test.com', 'test')
		visit "/schits/new"
		add_schit("First Schit.")
		time = Time.now
		expect(Schit.count).to eq(1)
		schit = Schit.first
		expect(schit.message).to eq("First Schit.")
		#note - we are checking the time values not the instances of time.
		expect(schit.time_stamp.to_i).to eq(time.to_i)
	end

	def add_schit(message)
		within('#new-schit') do
			fill_in 'message', :with => message
			click_button 'Schit!'
		end
	end
 
end
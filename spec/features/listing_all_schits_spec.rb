require 'spec_helper'

feature "User browses the list of schits" do

	before(:each) {
		Schit.create(:time_stamp => Time.now, 
								:message => "Hello World!")
	}

	scenario "when opening the home page" do
		visit '/'
		expect(page).to have_content("Hello World!")
	end
	
end
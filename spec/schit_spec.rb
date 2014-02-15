require 'spec_helper'

describe Schit do 
	context "Ensuring datamapper works" do
		it 'should be created and then retrieved from the database' do 
			expect(Schit.count).to eq(0)
			current_time = Time.now
			Schit.create(:message => "First Message", 
									:time_stamp => current_time)
			expect(Schit.count).to eq(1) 
			schit = Schit.first 
			expect(schit.time_stamp.to_i).to eq(current_time.to_i)
			expect(schit.message).to eq("First Message")
			schit.destroy
			expect(Schit.count).to eq(0)
		end
	end 

	context "ensuring datamapper provides access to relationships" do
		it 'should be created and user name and handle be available' do 
			user = User.create(:email => "test@test.com",
								:name => "Testname Testlastname",
								:user_name => "testusername",
								:password => 'test',
								:password_confirmation => 'test')
			expect(Schit.count).to eq(0)
			schit = Schit.create(:message => "First Message", 
									:time_stamp => Time.now, :user => user)
			expect(schit.message).to eq("First Message")
			expect(schit.user).to eq(user)
			expect(schit.user.name).to eq("Testname Testlastname")
			expect(schit.user.user_name).to eq("testusername")
			expect(Schit.count).to eq(1)
		end
	end
end



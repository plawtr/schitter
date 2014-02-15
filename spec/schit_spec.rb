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
end



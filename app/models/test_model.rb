class TestModel < ActiveRecord::Base


	def self.create_order
		u = User.new
		u.device_id = "mine"
		u.credits = 10
		u.save
	end

	def self.create_events

	end
end

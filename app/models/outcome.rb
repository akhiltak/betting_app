class Outcome < ActiveRecord::Base

	def recalculate_and_update_odds(outcome_id=nil, event_id=nil)
		# a new bet has been placed on this order

		

	end
	
  belongs_to :event
end

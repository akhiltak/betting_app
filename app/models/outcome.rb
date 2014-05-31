class Outcome < ActiveRecord::Base

	def recalculate_and_update_odds
		# a new bet has been placed on this order

		current_odds = self.odds

	end
	
  belongs_to :event
end

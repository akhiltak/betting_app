class Outcome < ActiveRecord::Base

	def recalculate_and_update_odds(outcome_id=nil, event_id=nil)
		# a new bet has been placed on this order

		total_odds = 0
		Event.find(event_id.to_i).outcomes.each do |x|
		 total_odds += x.odds.to_i
		end

		Event.find(event_id.to_i).outcomes.each do |x|
			x.odds_display_text = x.odds.to_s + ":" + (total_odds-x.odds.to_i).to_s
			x.save
		end
	end
	
  belongs_to :event
end

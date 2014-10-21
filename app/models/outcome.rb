class Outcome < ActiveRecord::Base
	
  belongs_to :event
  
	def recalculate_and_update_odds(outcome_id=nil, event_id=nil)
		# a new bet has been placed on this order

		total_odds = 0
		Event.find(event_id.to_i).outcomes.each do |x|
		 total_odds += x.odds.to_i+x.number_of_bets.to_i*(0.1)
		end

		Event.find(event_id.to_i).outcomes.each do |x|
			x.odds_display_text = (x.odds.to_i+x.number_of_bets.to_i*(0.1)).to_s + ":" + (total_odds-x.odds.to_i-x.number_of_bets.to_i*(0.1)).to_s
			x.save
		end
	end

end

module Api
class BetsController < ApiController

	def place_bet
    	if params[:device_id].blank? or params[:event_id].blank? or params[:outcome_id].blank? or params[:credits].blank?
    		render :json => {
                'error' => 'MISSING_PARAMS'
            },
          :status => 400
        elsif params[:credits] > User.where(:device_id => params[:device_id]).first.credits
        	render :json => {
        		'error' => 'NOT ENOUGH CREDITS IN ACCOUNT FOR THIS BET'
        	},
        	:status => 515
        else
        	# create a new bet for the user
        	bet = Bet.new
        	user = User.where(:device_id => params[:device_id]).first
        	bet.user_id=user.id
        	bet.event_id=params[:event_id]
        	bet.outcome_id=params[:outcome_id]
        	bet.bet_amount=params[:credits]
        	bet.total_bets_placed += 1	# update the total bet count for the event
        	bet.save

        	# update the bet count in the corresponding output
        	outcome = Outcome.find(:outcome_id)
        	outcome.number_of_bets += 1
        	outcome.recalculate_and_update_odds #recalculate the odds here
        	outcome.save

        	#decrease user credits
        	user.credits -= params[:credits]
        	user.save

        	render :json => {
        		'new_bet' => bet,
        		'user' => user
        	},
        	:status => 200

    	end
    end
end
end


# , event_id, outcome_id, credits 
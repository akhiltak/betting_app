module Api
class BetsController < ApiController

    before_filter :authenticate_user

	def place_bet
    	if params[:device_id].blank? or params[:event_id].blank? or params[:outcome_id].blank? or params[:credits].blank?
    		render :json => {
                'error' => 'MISSING_PARAMS'
            },
          :status => 400
        elsif params[:credits].to_i > @user.credits.to_i
        	render :json => {
        		'error' => 'NOT ENOUGH CREDITS IN ACCOUNT FOR THIS BET'
        	},
        	:status => 515
        else
        	# create a new bet for the user
        	# bet = Bet.new
        	# user = User.where(:device_id => params[:device_id]).first
        	# bet.user_id=user.id
            @bet = @user.bets.new
        	@bet.event_id=params[:event_id].to_i
        	@bet.outcome_id=params[:outcome_id].to_i
        	@bet.bet_amount=params[:credits].to_i
        	# bet.total_bets_placed = 1	# update the total bet count for the event
        	@bet.save

        	# update the bet count in the corresponding output
        	outcome = Outcome.find(params[:outcome_id].to_i)
        	outcome.number_of_bets += 1
        	outcome.recalculate_and_update_odds(params[:outcome_id],params[:event_id]) #recalculate the odds here
        	outcome.save

            event = Event.find(params[:event_id].to_i)
            event.total_bets += 1
            event.save

        	#decrease user credits
        	@user.credits -= params[:credits].to_i
        	@user.save

            EventsController.event_completion("BET_PLACED",@user.device_id)

        	render :json => {
        		'status' => "SUCCESS"
        	},
        	:status => 200

    	end
    end
end
end


# , event_id, outcome_id, credits 
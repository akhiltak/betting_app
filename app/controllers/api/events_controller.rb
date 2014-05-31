module Api
class EventsController < ApiController

  before_filter :authenticate_user

  def index
    response = {}
    slack_time = 5.minutes
    response['all_events'] = Event.where("open_till > ?", Time.zone.now + slack_time).collect { |event|
      {
        'id' => event.id,
        'name' => event.name,
        'desc' => event.desc,
        'category' => event.category,
        'total_bets' => event.total_bets,
        'open_till' => event.open_till.to_i,
        'outcomes' => event.outcomes.collect { |outcome|
          {
            'id' => outcome.id,
            'name' => outcome.outcome_name,
            'odds_display_text' => outcome.odds_display_text,
            'number_of_bets' => outcome.number_of_bets
          }
        }
      }
    }

    response['my_bets'] = Bet.joins('INNER JOIN events ON events.id = bets.event_id').where("events.status = ? and bets.user_id = ?", 'OPEN', @user.id ).collect { |x|
      {
        'id' => x.id,
        'event_name' => Event.where(:id => x.event_id).first.name,
        'bet_amount' => x.bet_amount,
        'outcome_name' => Outcome.where(:id => x.outcome_id).first.outcome_name
      }
    }
    render :json => response, :status => 200
  end
#user_status will be "lost" or "win"
  def self.event_completion(action, device_id, event_id = nil, bet_id=nil, user_status)
    user = User.where(:device_id => device_id).first resue nil
    if user.nil?
      return
    end

    if action == "EVENT_COMPLETED"
      data = {
        :name => user.name,
        :device_id => device_id.to_s,
        :event_name => Event.find(event_id).name,
        :user_status => user_status,
        :credits => Bet.find(bet_id).bet_amount
      }
      
    ParseModel.push_notification('event_result_received', "user_" + device_id.to_s, data)
  end
end

end
end
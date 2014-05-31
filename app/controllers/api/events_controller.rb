module Api
class EventsController < ApiController

  before_filter :authenticate_user

  def index
    response = {}
    slack_time = 5.minutes
    response['all_bets'] = Event.where("open_till > ?", Time.zone.now + slack_time).collect { |event|
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
        'event_id' => x.event_id,
        'bet_amount' => x.bet_amount,
        'outcome_id' => x.outcome_id
      }
    }
    render :json => response, :status => 200
  end


end
end
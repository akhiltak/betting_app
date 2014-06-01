module HelperModel

  def self.get_response user
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
        'bet_placed' => !user.bets.where(:event_id => event.id.to_i).first.nil? ,
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

    response['my_bets'] = Bet.joins('INNER JOIN events ON events.id = bets.event_id').where("events.status = ? and bets.user_id = ?", 'OPEN', 1 ).collect { |x|
      {
        'id' => x.id,
        'event_name' => Event.find(x.event_id).name,
        'bet_amount' => x.bet_amount,
        'outcome_name' => Outcome.find(x.outcome_id).outcome_name,
        'time_remaining' =>  ((Event.find(x.event_id).open_till - Time.zone.now)/1.days).to_i,
        'current_odds' => Outcome.find(x.outcome_id).odds_display_text
      }
    }
    response['credits'] = user.credits
    return response
  end

end

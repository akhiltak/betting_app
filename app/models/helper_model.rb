module HelperModel

  def self.get_response user
    response = {}
    slack_time = 5.minutes
    response['all_events'] = Event.where("open_till > ?", Time.zone.now + slack_time).order('total_bets desc').collect { |event|
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
            'returns' => find_returns(outcome.odds_display_text),
            'odds_display_text' => outcome.odds_display_text,
            'number_of_bets' => outcome.number_of_bets
          }
        }
      }
    }

    response['my_bets'] = Bet.joins('INNER JOIN events ON events.id = bets.event_id').where("events.status = ? and bets.user_id = ?", 'OPEN', user.id ).collect { |x|
      {
        'id' => x.id,
        'event_name' => Event.find(x.event_id).name,
        'bet_amount' => x.bet_amount,
        'outcome_name' => Outcome.find(x.outcome_id).outcome_name,
        'time_remaining' =>  calculate_remaining_time(x.event_id),
        'current_odds' => find_returns(Outcome.find(x.outcome_id).odds_display_text)
      }
    }

    if user.credits.to_i < 100
      user.credits += 100
    end

    response['credits'] = user.credits
    return response
  end

  def self.find_returns odds_ratio
    total_odds = 0
    odds_ratio.split(":").each { |x| 
      total_odds += x.to_i
    }
    return (1+(1.0)*odds_ratio.split(":").first.to_i/total_odds).round(2)
  end

  def self.calculate_remaining_time event_id
    days, time_remaining = (Event.find(event_id).open_till - Time.zone.now).divmod(1.day)
    hours, time_remaining = time_remaining.divmod(1.hour)
    minutes, seconds = time_remaining.divmod(1.minute)
    seconds=seconds.to_i

    if days.to_i != 0
      time_remaining = "#{days} days, #{hours} hours"
    elsif hours.to_i != 0
      time_remaining = "#{hours} hours, #{minutes} minutes"
    elsif minutes != 0
      time_remaining = "#{minutes} minutes, #{seconds} seconds"
    else
      time_remaining = "#{seconds} seconds"
    end
    return time_remaining.to_s
  end
end

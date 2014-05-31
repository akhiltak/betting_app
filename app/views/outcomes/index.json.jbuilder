json.array!(@outcomes) do |outcome|
  json.extract! outcome, :id, :outcome_name, :event_id, :odds, :number_of_bets, :odds_display_text
  json.url outcome_url(outcome, format: :json)
end

json.array!(@bets) do |bet|
  json.extract! bet, :id, :user_id, :bet_amount, :event_id, :outcome_id
  json.url bet_url(bet, format: :json)
end

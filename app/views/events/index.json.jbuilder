json.array!(@events) do |event|
  json.extract! event, :id, :name, :desc, :category, :expected_completion_time, :total_bets
  json.url event_url(event, format: :json)
end

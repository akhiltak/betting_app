json.array!(@events) do |event|
  json.extract! event, :id, :name, :desc, :category, :open_till, :results_till, :total_bets
  json.url event_url(event, format: :json)
end

json.extract! event, :id, :date, :required_age, :name, :desc, :price, :free_seats, :poster, :created_at, :updated_at
json.url event_url(event, format: :json)

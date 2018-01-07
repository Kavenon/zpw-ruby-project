json.extract! ticket, :id, :price, :seat, :want_delete, :user_id, :event_id, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)

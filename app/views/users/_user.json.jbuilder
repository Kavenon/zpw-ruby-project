json.extract! user, :id, :email, :name, :admin, :birthday, :created_at, :updated_at
json.url user_url(user, format: :json)

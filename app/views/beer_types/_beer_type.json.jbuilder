json.extract! beer_type, :id, :name, :description, :created_at, :updated_at
json.url beer_type_url(beer_type, format: :json)

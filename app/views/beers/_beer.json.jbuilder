json.extract! beer, :id, :name, :alcohol, :ibu, :description, :producer_id, :created_at, :updated_at
json.url beer_url(beer, format: :json)

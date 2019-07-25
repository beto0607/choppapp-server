json.extract! vote, :id, :score, :user_id, :beer_id, :description, :created_at, :updated_at
json.url vote_url(vote, format: :json)

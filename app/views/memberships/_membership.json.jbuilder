json.extract! membership, :id, :beer_club_id, :integer, :user_id, :integer, :created_at, :updated_at
json.url membership_url(membership, format: :json)

json.extract! room, :id, :name, :description, :price, :rules, :address, :images, :city_id, :user_id, :latitude, :longitude, :created_at, :updated_at
json.url room_url(room, format: :json)

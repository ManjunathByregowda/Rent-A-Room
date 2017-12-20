class Amenity < ActiveRecord::Base

	has_many :amenity_rooms
	has_many :rooms, through: :amenity_rooms

	extend FriendlyId
	friendly_id :name, use: [:slugged, :finders]

	validates_presence_of :name, :description
end

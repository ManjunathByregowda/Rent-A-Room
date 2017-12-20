class Review < ActiveRecord::Base

	belongs_to :user
	belongs_to :room

	validates_presence_of :review, :food_rating, :cleanliness_rating, :safety_rating, :facility_rating, :locality_rating
	validates_length_of :review,  minimum: 150
end

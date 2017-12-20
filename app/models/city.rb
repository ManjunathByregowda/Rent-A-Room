class City < ActiveRecord::Base

	has_many :rooms

	extend FriendlyId
  	friendly_id :name, use: [:slugged, :finders]

	validates_presence_of :name
end

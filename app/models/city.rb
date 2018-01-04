class City < ActiveRecord::Base

	has_many :rooms, dependent: :destroy

	extend FriendlyId
  	friendly_id :name, use: [:slugged, :finders]

	validates_presence_of :name
end

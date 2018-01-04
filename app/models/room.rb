class Room < ActiveRecord::Base

	mount_uploader :images, ImageUploader

	has_many :amenity_rooms
	has_many :amenities, through: :amenity_rooms
	has_many :bookings, dependent: :destroy
	has_many :special_prices
	has_many :reviews
	belongs_to :city
	belongs_to :user

	extend FriendlyId
  	friendly_id :name, use: [:slugged, :finders]

	before_save :determine_latitude_and_longitude
	before_destroy :check_all_bookings
	after_create :change_role
	after_update :authorization_confirmation
	#after_create :authorization

	validates_presence_of :name, :description, :price, :rules, :address, :images,  :city_id, :user_id
	validates_numericality_of :price, :city_id, :user_id
	validates_processing_of :images
	#validate :image_size_validation

	def change_role
		
		if self.user.role.name == "guest"
			self.user.update_attributes(role_id: Role.second.id)
		
		end
	end

	def determine_latitude_and_longitude
		response = HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{self.address}&key=AIzaSyBDBSV9LOvH-VYy2k4YkZ4jhjInjs6d74s")
		binding.pry
		self.latitude = response["results"][0]["geometry"]["location"]["lat"]
		self.longitude = response["results"][0]["geometry"]["location"]["lng"]
	end

	def authorization_confirmation
		if self.is_authorized == true
			Notification.authorization_confirmation(self).deliver_now!
		end
	end

	def check_all_bookings
		binding.pry
		self.bookings.each do |date|
			binding.pry
			if date.end_date > Date.today
				binding.pry
				redirect_to @room_path, notice: "You can't delete your room still all the bookings get clear"
				break
			end
		end
	end

	# def authorization
	# 	self.is_authorized == "true"		
	# end

	
 
	# private

	#   def image_size_validation
	#     errors[:image] << "should be less than 500KB" if image.size > 0.5.megabytes
	#   end
end

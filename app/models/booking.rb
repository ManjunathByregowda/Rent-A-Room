class Booking < ActiveRecord::Base

	#before_validation :booking_price
	 after_create :booking_creation
	 after_update :booking_confirmation
	
	belongs_to :room
	belongs_to :user

	validates_presence_of :start_date, :end_date, :user_id, :room_id
	validate :valuable_dates, on: :create
	validate :check_room_dates, on: :create
	validate :booking_price_calculation, on: :create

	# validate :special_price_calculation, on: :create




	def booking_creation
		Notification.booking_created(self).deliver_now!
		Notification.booking_need_confirmation(self).deliver_now!
	end

	def booking_confirmation
		if self.is_confirmed == true
			Notification.booking_confirmation(self).deliver_now!
		end
	end

	# def booking_price
	# 	self.price = (self.start_date...self.end_date).count * self.room.price
	# end

	private

	def valuable_dates
		if self.start_date < Date.today
			self.errors.add(:start_date, "Your Booking Start Date must be greater than today")
		end
		if (self.end_date < self.start_date)
			self.errors.add(:end_date, "Your Booking End Date must be greater than Start Date")
		end
	end

	def check_room_dates
		n1 = self.start_date
		n2 = self.end_date

		now_booking = (n1..n2).to_a

		previous_booking = Booking.where('room_id=?', self.room_id)
		previous_booking.each do |pdate|
			n3 = pdate.start_date
			n4 = pdate.end_date

			all_previous_booking = (n3..n4).to_a

			now_booking.each do |date|
				if all_previous_booking.include?(date)
					self.errors.add(:base, "theis room is already booked " )
					break
				end
			end
		end

	end

	# def special_price_calculation

	# 	if room.special_prices.any?
	# 		# binding.pry
	# 		n1 = self.start_date
	# 		n2 = self.end_date

	# 		now_booking = (n1..n2).to_a
	# 			 binding.pry
	# 			 special_dates = []			
	# 			 pecial_dates = SpecialPrice.where('room_id=?', self.room_id)

	# 			special_dates.each do |sdate|
				
					
	# 					n3 = sdate.start_date
	# 					n4 = sdate.end_date
	# 					 binding.pry
	# 					all_special_dates = (n3..n4).to_a

				
	# 					if (all_special_dates.include?(date))
	# 						 binding.pry
	# 						self.price = self.price.to_i + sdate.price.to_i
	# 					else
	# 						binding.pry
	# 						self.price = self.price.to_i + self.room.price.to_i
	# 					end
	# 				end
	# 			end
	# 	else
	# 		binding.pry
	# 		self.price = (self.start_date..self.end_date).count * self.room.price
	# 	end
	# 				binding.pry

	# end
	
	def booking_price_calculation
		current_booking = (self.start_date..self.end_date).to_a
		price = []

		special_bookings = SpecialPrice.where('room_id=?', self.room_id)
		binding.pry
		special_bookings.each do |sdate|
			special_booking = (sdate.start_date..sdate.end_date).to_a

			if !(current_booking&special_booking).empty?
				binding.pry
				price << (current_booking&special_booking).count * sdate.price
				current_booking -= special_booking
				binding.pry
			end
		end

		if price.empty?
			special_booking_price = 0
			binding.pry
		else
			special_booking_price = price.inject(:+)
			binding.pry
		end

		normal_day_cost = (current_booking.length) * self.room.price
		self.price = (special_booking_price + normal_day_cost)
		binding.pry


	end
end

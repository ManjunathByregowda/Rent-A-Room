class SpecialPrice < ActiveRecord::Base
	belongs_to :room

	validates_presence_of :start_date, :end_date, :price, :room_id
	validates_numericality_of :price, :room_id 
	validate :check_current_dates, on: :create
	validate :check_special_booked_dates, on: :create

	def check_current_dates
		if self.start_date < Date.today
			self.errors.add(:base, "startdate must be greater than todays date")
		end
		if (self.end_date < self.start_date)
			self.errors.add(:base, "end date must be greter than start date")
		end
	end

	def check_special_booked_dates
		current_dates = (self.start_date..self.end_date).to_a

		special_dates = SpecialPrice.where('room_id=?', self.room_id)

		special_dates.each do |sdate|
		 	special_date = (sdate.start_date..sdate.end_date).to_a
		 	binding.pry
		 	current_dates.each do |date|
		 		if special_date.include?(date)
		 			binding.pry
		 			self.errors.add(:base, "this date has special price")
		 			break
		 		end
		 	end
		end
	end


end

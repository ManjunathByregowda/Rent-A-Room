class Notification < ApplicationMailer

	def authorization_confirmation(room)    
		@room = room
		mail to: "#{room.user.email}", subject: "Your Room authorization is confirmed"
	end

	def booking_created(booking)
		@booking = booking
		mail to: "#{booking.user.email}", subject: "Your Room booking was created, but still not confirmed"
	end

	def booking_need_confirmation(booking)
		@booking = booking
		mail to: "#{booking.room.user.email}", subject: "Your have new room to Confirm"
	end 

	def booking_confirmation(booking)
		@booking = booking
		mail to: "#{booking.user.email}", sbject: "your Booking room was confirmed"
	end
end

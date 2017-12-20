class BookingsController < ApplicationController

	before_action :authenticate_user!
	load_and_authorize_resource

	def my_bookings
		@bookings = current_user.bookings
	end

	def create
		@booking = Booking.new(booking_params)
		if current_user.role.name != "admin"
			@booking.user_id = current_user.id
		end
		#binding.pry
		if @booking.save
			render action: "show", notice: "Your room is succesfully Booked"
		else
			render action: "new"
		end
	end

	def update
		@booking = Booking.find(params[:id])
		if @booking.update_attributes(booking_params)
			redirect_to @booking.room
		else
			redirect_to bookings_confirmation_path, notice: "unable to update the booking "
		end
	end

	def confirmation
		@bookings = Booking.where('is_confirmed= ?', false)
	end




	private

	def booking_params
		#binding.pry
		params[:booking].permit(:start_date, :end_date, :price, :room_id, :user_id, :is_confirmed)
	end
end

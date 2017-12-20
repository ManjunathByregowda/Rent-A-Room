class SpecialPricesController < ApplicationController
	before_action :authenticate_user!
	load_and_authorize_resource

	def create
		@special_price = SpecialPrice.new(special_price_params)
		binding.pry
		if @special_price.save
			redirect_to room_path(@special_price.room_id), notice: "you have sucessfully created special price"
		else
			render action: "new"
		end
	end

	private

	def special_price_params
		params[:special_price].permit(:start_date, :end_date, :price, :room_id)
	end
end

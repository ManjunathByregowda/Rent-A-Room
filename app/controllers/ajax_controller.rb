class AjaxController < ApplicationController
  def low_to_high
  	@rooms = Room.order(:price)
  	render json: @rooms
  end

  def high_to_low
  	@rooms = Room.order(price: :desc)
  	render json: @rooms
  end

  def find_by_city
    if params[:city_ids] != ""
  	  @rooms = Room.where(city_id: params[:city_ids].split(","))
    else
      @rooms = Room.all
    end
  	render json: @rooms
  end
end

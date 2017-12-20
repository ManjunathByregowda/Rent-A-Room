class RoomsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource
  before_action :set_room, only: [:edit, :update, :destroy]

  # GET /rooms
  # GET /rooms.json
  def index
    #@rooms = Room.all
    @rooms = Room.where('is_authorized=?', true)
    @room = Room.paginate(:page => params[:page], :per_page => 5)
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
     @room = Room.friendly.find(params[:id])
    @booking = Booking.new
    @special_price = SpecialPrice.new
    @review = Review.new
    #@reviews = Review.where('room_id=?', current_user.booking)
    #@booking =  Booking.where('room_id=?', current_user.)
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = Room.new(room_params)
    binding.pry
    respond_to do |format|
      @room.user_id = current_user.id
      if @room.save
        binding.pry
        format.html { redirect_to @room, notice: 'Room was successfully created.' }
        format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1
  # PATCH/PUT /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to @room, notice: 'Room was successfully updated.' }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end    
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    if @room.destroy
      # respond_to do |format|
        redirect_to rooms_url, notice: 'Room was successfully destroyed.'
      #   format.json { head :no_content }
      # end
    else
      redirect_to @room, notice: "You can't delete your room still all the bookings get clear"
    end
  end

  def my_rooms
    @rooms = current_user.rooms
  end

  def authorization
    @rooms = Room.where('is_authorized=?', false )
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      params.require(:room).permit(:name, :description, :price, :rules, :address, :images, :city_id, :user_id, :latitude, :longitude, :is_authorized, amenity_ids: [])
    end

end

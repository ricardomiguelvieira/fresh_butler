class BookingsController < ApplicationController
  before_action :find_booking, only: [:show, :update, :destroy, :edit]

  def index
    #need authorization for specific user to view his bookings
    @user = User.find(params[:user_id])
    @bookings = Booking.all
  end

  def show
  end

  def new
    @booking = Booking.new
    @butler = User.find(params[:user_id])
  end

  def update
    if @booking.update(bookings_params)
      redirect_to booking_path(@booking), notice: 'Booking was updated!'
    else
      render :new
    end
  end

  def create
    @booking = Booking.new(bookings_params)
    @booking.client = current_user
    @booking.butler = User.find(params[:user_id])
    if @booking.save
      redirect_to booking_path(@booking), notice: 'Booking has been made!'
    else
      render :new
    end
  end

  def edit
    # @booking = current_user.client_bookings
     # @butler = @booking.butler
  end

  def destroy
    @booking.destroy
    redirect_to user_session_path(@booking.user)
  end

  private

  def bookings_params
    params.require(:booking).permit(:start_date, :end_date, :user_id)
  end

  def find_booking
    @booking = Booking.find(params[:id])
  end
end
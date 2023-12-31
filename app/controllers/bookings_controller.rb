class BookingsController < ApplicationController
  before_action :set_booking, only: %i[edit update destroy]

  def new
    booking = Booking.new
    authorize booking
  end

  def create
    booking = Booking.new(user: current_user, booking_datetime: booking_params[:booking_datetime])
    authorize booking
    if booking.save
      render json: { message: 'Reserva realizada.', booking: booking.id }, status: 200
    else
      render json: { message: 'Não foi possível realizar a reserva' }, status: 422
    end
  end

  def edit; end

  def update
    if @booking.update(booking_params)
      flash[:alert] = 'Reserva alterada.'
    else
      flash[:notice] = 'Não foi possível realizar a alteração da reserva. Verifique se data e horário estão no passado ou se já há uma reserva na data e horário desejado.'
    end
    redirect_to(request.referrer || root_path)
  end

  def destroy
    @booking.destroy
    render json: { message: 'Reserva cancelada.' }, status: 200
  end

  private

  def booking_params
    params.require(:booking).permit(:booking_datetime)
  end

  def set_booking
    @booking = Booking.find(params[:id])
    authorize @booking
  end
end

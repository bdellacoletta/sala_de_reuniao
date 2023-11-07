class BookingsController < ApplicationController
  def new
    booking = Booking.new
    authorize booking
  end

  def create
    booking_datetime = "#{params[:date]} #{params[:hour]}"
    booking = Booking.new(user: current_user, booking_datetime: booking_datetime.to_datetime)
    authorize booking
    if booking.save
      render json: { message: 'Reserva realizada.', booking: booking.id }, status: 200
    else
      render json: { message: 'Não foi possível realizar a reserva' }, status: 422
    end
  end

  def destroy
    booking = Booking.find(params[:id])
    authorize booking
    booking.destroy

    render json: { message: 'Reserva cancelada.' }, status: 200
  end
end

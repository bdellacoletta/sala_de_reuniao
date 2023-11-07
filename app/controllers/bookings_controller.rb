class BookingsController < ApplicationController
  def destroy
    booking = Booking.find(params[:id])
    booking.destroy

    render json: { message: 'Reserva cancelada.' }, status: 200
  end
end

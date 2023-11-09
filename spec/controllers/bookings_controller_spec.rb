require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
  let(:user) { create(:user) }
  let(:booking) { create(:booking, user: user) }

  before { sign_in user }

  describe '#new booking' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe '#create booking' do
    it 'creates a new booking' do
      post :create, params: { booking: { booking_datetime: Time.now } }
      expect(response).to have_http_status(200)
    end

    it 'fails to create a booking with invalid data' do
      post :create, params: { booking: { booking_datetime: nil } }
      expect(response).to have_http_status(422)
    end
  end

  describe '#edit booking' do
    it 'returns a success response' do
      get :edit, params: { id: booking.id }
      expect(response).to be_successful
    end
  end

  describe '#update booking' do
    it 'updates a booking' do
      put :update, params: { id: booking.id, booking: { booking_datetime: Time.now } }
      expect(flash[:alert]).to eq('Reserva alterada.')
      expect(response).to redirect_to(request.referrer || root_path)
    end

    it 'fails to update a booking with invalid data' do
      put :update, params: { id: booking.id, booking: { booking_datetime: nil } }
      expect(flash[:notice]).to eq('Não foi possível realizar a alteração da reserva, verifique se data e horário não estão no passado.')
      expect(response).to redirect_to(request.referrer || root_path)
    end
  end

  describe '#destroy booking' do
    it 'destroys a booking' do
      delete :destroy, params: { id: booking.id }
      expect(response).to have_http_status(200)
    end
  end
end

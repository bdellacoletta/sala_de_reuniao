require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
  let(:user) { create(:user) }
  let!(:booking) { create(:booking, user: user) }

  before { sign_in user }

  describe '#new booking' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe '#create booking' do
    it 'creates a new booking' do
      expect {
        post :create, params: { booking: { booking_datetime: DateTime.now } }
      }.to change(Booking, :count).by(1)
      expect(response).to have_http_status(200)
    end

    it 'fails to create a booking with invalid data' do
      expect{
        post :create, params: { booking: { booking_datetime: DateTime.now - 1 } }
      }.to change(Booking, :count).by(0)
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
      put :update, params: { id: booking.id, booking: { booking_datetime: DateTime.now } }
      expect(flash[:alert]).to eq('Reserva alterada.')
      expect(response).to redirect_to(request.referrer || root_path)
    end

    it 'fails to update a booking with invalid data' do
      put :update, params: { id: booking.id, booking: { booking_datetime: DateTime.now - 1 } }
      expect(flash[:notice]).to eq('Não foi possível realizar a alteração da reserva. Verifique se data e horário estão no passado ou se já há uma reserva na data e horário desejado.')
      expect(response).to redirect_to(request.referrer || root_path)
    end
  end

  describe '#destroy booking' do
    it 'destroys a booking' do
      expect{
        delete :destroy, params: { id: booking.id }
      }.to change(Booking, :count).by(-1)
      expect(response).to have_http_status(200)
    end
  end
end

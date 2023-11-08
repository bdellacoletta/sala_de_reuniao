require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
  let(:user) { create(:user) }
  let(:booking) { create(:booking, user: user) }

  before { sign_in user }

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    it 'creates a new booking' do
      post :create, params: { booking: { booking_datetime: Time.now } }
      expect(response).to have_http_status(200)
    end

    it 'fails to create a booking with invalid data' do
      post :create, params: { booking: { booking_datetime: nil } }
      expect(response).to have_http_status(422)
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: booking.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PUT #update' do
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

  describe 'DELETE #destroy' do
    it 'destroys a booking' do
      delete :destroy, params: { id: booking.id }
      expect(response).to have_http_status(200)
    end
  end
end

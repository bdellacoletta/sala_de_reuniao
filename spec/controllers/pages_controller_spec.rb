require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  let(:user) { create(:user) }

  before { sign_in user }

  describe 'should get home' do
    it 'returns a success response' do
      get :home
      expect(response).to have_http_status(:success)
    end
  end
end

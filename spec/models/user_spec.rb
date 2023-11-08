require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:bookings) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
  end

  context 'validation for email regex' do
    let(:user) { build(:user, email: 'user@example.com') }
    it { is_expected.to allow_value('user@example.com').for(:email) }
    it { is_expected.not_to allow_value('userexample.com').for(:email) }
  end
end

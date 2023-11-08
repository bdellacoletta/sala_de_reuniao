require 'rails_helper'

RSpec.describe Booking, type: :model do
  subject { build(:booking) }

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:booking_datetime) }

    context 'when booking_datetime is in the past' do
      let(:user) { build(:user) }
      let(:booking) { build(:booking, booking_datetime: Date.today - 1) }
      it { should_not allow_value(booking.booking_datetime).for(:booking_datetime) }
    end
  end
end

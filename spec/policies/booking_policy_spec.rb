require 'rails_helper'

RSpec.describe BookingPolicy, type: :policy do
  let(:user) { create(:user) }

  subject { described_class }

  permissions :create? do
    it 'allows access for authenticated users' do
      expect(subject).to permit(user)
    end

    it 'does not allow access for guests (unauthenticated users)' do
      expect(subject).not_to permit(nil)
    end
  end

  permissions :update?, :destroy? do
    let(:booking) { create(:booking, user: user) }

    it 'allows access for the owner of the booking' do
      expect(subject).to permit(user, booking)
    end

    it 'does not allow access for users who do not own the booking' do
      other_user = create(:user)
      expect(subject).not_to permit(other_user, booking)
    end
  end


end

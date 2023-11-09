class Booking < ApplicationRecord
  belongs_to :user

  validates :booking_datetime, presence: true

  validate :booking_cannot_be_in_past

  def booking_cannot_be_in_past
    if booking_datetime && booking_datetime.strftime('%d/%m/%Y %H:%M') < Time.now.strftime('%d/%m/%Y %H:%M')
      errors.add(:booking_datetime, "can't be in the past.")
    end
  end
end

class Booking < ApplicationRecord
  belongs_to :user

  validates :booking_datetime, presence: true, uniqueness: true

  validate :booking_cannot_be_in_past

  def booking_cannot_be_in_past
    if booking_datetime.present? && (booking_datetime.to_date < Date.today ||
      (booking_datetime.to_date == Date.today && booking_datetime.hour < Time.now.hour))
      errors.add(:booking_datetime, "can't be in the past.")
    end
  end
end

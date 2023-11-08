FactoryBot.define do
  factory :booking do
    booking_datetime { Faker::Time.between(from: DateTime.now, to: DateTime.now + 15) }
  end
end

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }

    trait :with_booking do
      booking { create(:booking) }
    end
  end
end

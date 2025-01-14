FactoryBot.define do
  factory :event do
    name { Faker::Lorem.sentence(word_count: 3) }
    description { Faker::Lorem.paragraph }
    location { Faker::Address.full_address }
    start_time { Faker::Time.forward(days: 30, period: :day) }
    total_tickets { rand(50..100) }
    remaining_tickets { total_tickets }
    association :creator, factory: :user
  end
end
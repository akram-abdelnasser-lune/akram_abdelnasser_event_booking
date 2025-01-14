require 'faker'

# Create Users
10.times do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password'
  )
end

users = User.all

# Create Events
20.times do
  Event.create!(
    name: Faker::Lorem.sentence(word_count: 3),
    description: Faker::Lorem.paragraph,
    location: Faker::Address.full_address,
    start_time: Faker::Time.forward(days: 30, period: :day),
    total_tickets: rand(50..100),
    remaining_tickets: rand(50..100),
    creator: users.sample
  )
end

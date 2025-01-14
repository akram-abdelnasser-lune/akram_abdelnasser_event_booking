require 'faker'

# Create Users
100.times do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password'
  )
end

users = User.all

# Create Events
50.times do
  event = Event.create!(
    name: Faker::Lorem.sentence(word_count: 3),
    description: Faker::Lorem.paragraph,
    location: Faker::Address.full_address,
    start_time: Faker::Time.forward(days: 30, period: :day),
    total_tickets: rand(50..1000),
    remaining_tickets: rand(50..1000),
    creator: users.sample
  )
  rand(1..5).times do
    number_of_tickets = rand(1..20)
    user = users.sample
  
    if event.remaining_tickets >= number_of_tickets
      event.book_or_update_tickets(user, number_of_tickets)
    end
  end
end


# filepath: /Users/akram.abdelnasser/Documents/private/events_booking/app/models/booking.rb
class Booking < ApplicationRecord
  # ASSOCIATIONS #
  belongs_to :user
  belongs_to :event

  # VALIDATIONS #
  validates :number_of_tickets, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :user_id, uniqueness: { scope: :event_id, message: "can only have one booking per event" }
end
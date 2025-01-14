module Ticketable
  extend ActiveSupport::Concern

  included do
    def book_or_update_tickets(user, new_number_of_tickets, booking = nil)
      with_lock do
        if booking
          return false unless can_update_tickets?(new_number_of_tickets, booking)
          update_remaining_tickets(new_number_of_tickets, booking)
        else
          return false unless can_book_tickets?(new_number_of_tickets)
          decrement_remaining_tickets(new_number_of_tickets)
        end

        save!
        persist_booking(user, new_number_of_tickets, booking)
      end
      true
    rescue ActiveRecord::RecordInvalid
      errors.add(:base, "Failed to book tickets due to a save error")
      false
    end

    private

    def can_book_tickets?(number_of_tickets)
      if remaining_tickets >= number_of_tickets
        true
      else
        errors.add(:base, "Not enough tickets available")
        false
      end
    end

    def can_update_tickets?(new_number_of_tickets, booking)
      old_number_of_tickets = booking.number_of_tickets
      if remaining_tickets + old_number_of_tickets >= new_number_of_tickets
        true
      else
        errors.add(:base, "Not enough tickets available")
        false
      end
    end

    def decrement_remaining_tickets(number_of_tickets)
      self.remaining_tickets -= number_of_tickets
    end

    def update_remaining_tickets(new_number_of_tickets, booking)
      old_number_of_tickets = booking.number_of_tickets
      self.remaining_tickets += old_number_of_tickets - new_number_of_tickets
    end

    def persist_booking(user, number_of_tickets, booking)
      if booking
        booking.update!(number_of_tickets: number_of_tickets)
      else
        bookings.create!(user: user, number_of_tickets: number_of_tickets)
      end
    end
  end
end
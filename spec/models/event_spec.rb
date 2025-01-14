require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:event) { create(:event, total_tickets: 10, remaining_tickets: 10) }

  describe '#book_tickets' do
    context 'when booking is successful' do
      it 'reduces the remaining tickets and creates a booking' do
        expect(event.book_or_update_tickets(user1, 5)).to be_truthy
        event.reload
        expect(event.remaining_tickets).to eq(5)
        expect(event.bookings.count).to eq(1)
        expect(event.bookings.first.user).to eq(user1)
        expect(event.bookings.first.number_of_tickets).to eq(5)
      end
    end

    context 'when trying to book more tickets than available' do
      it 'does not allow the booking and adds an error' do
        expect(event.book_or_update_tickets(user1, 15)).to be_falsey
        expect(event.errors[:base]).to include('Not enough tickets available')
        event.reload
        expect(event.remaining_tickets).to eq(10)
        expect(event.bookings.count).to eq(0)
      end
    end

    context 'when two users try to book the last 10 tickets at the same time' do
      it 'allows only one booking to succeed' do
        threads = []

        threads << Thread.new { event.book_or_update_tickets(user1, 10) }
        threads << Thread.new { event.book_or_update_tickets(user2, 10) }

        threads.each(&:join)

        event.reload
        expect(event.remaining_tickets).to eq(0).or eq(10)
        expect(event.bookings.count).to eq(1)
      end
    end
  end
end
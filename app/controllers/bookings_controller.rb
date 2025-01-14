# filepath: /Users/akram.abdelnasser/Documents/private/events_booking/app/controllers/bookings_controller.rb
class BookingsController < ApplicationController
  load_and_authorize_resource :event
  load_and_authorize_resource :booking, through: :event

  def create
    number_of_tickets = booking_params[:number_of_tickets].to_i
    @booking.user = current_user

    if @event.book_or_update_tickets(current_user, number_of_tickets)
      redirect_to event_path(@event), notice: 'Tickets successfully booked.'
    else
      @booking.errors.add(:base, @event.errors.full_messages.join(", "))
      render :new, status: :unprocessable_entity
    end
  end

  def update
    number_of_tickets = booking_params[:number_of_tickets].to_i

    if @event.book_or_update_tickets(current_user, number_of_tickets, @booking)
      redirect_to event_path(@event), notice: 'Booking successfully updated.'
    else
      @booking.errors.add(:base, @event.errors.full_messages.join(", "))
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.with_lock do
      @event.remaining_tickets += @booking.number_of_tickets
      @event.save!
      @booking.destroy
    end
    redirect_to event_path(@event), notice: 'Booking successfully canceled.'
  end

  private

  def booking_params
    params.require(:booking).permit(:number_of_tickets)
  end
end
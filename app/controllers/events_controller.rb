class EventsController < ApplicationController
  load_and_authorize_resource
  def index
    @filter = params[:filter]
    @events = case @filter
              when 'my_created_events'
                current_user.created_events.future_events.page(params[:page])
              when 'my_booked_events'
                current_user.booked_events.future_events.page(params[:page])
              else
                Event.future_events.page(params[:page])
              end
  end

  def create
    @event.creator = current_user
    if @event.save
      redirect_to events_path, notice: 'Event successfully created.'
    else
      render :new
    end
  end

  def show
    @bookings = @event.bookings.page(params[:page]) if @event.creator == current_user
    @booking = @event.bookings.find_by_user_id(current_user.id)
    @can_create_booking = @booking.blank? && @event.start_time > Time.now && @event.creator != current_user
  end

  def update
    if @event.update(event_params)
      redirect_to events_path, notice: 'Event successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: 'Event successfully deleted.'
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :location, :start_time, :total_tickets)
  end
end
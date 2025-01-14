class EventsController < ApplicationController
  load_and_authorize_resource
  def index
    @events = Event.future_events.page(params[:page])
  end

  def create
    @event.creator = current_user
    if @event.save
      redirect_to events_path, notice: 'Event successfully created.'
    else
      render :new
    end
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
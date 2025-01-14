class EventsController < ApplicationController
  def index
    @events = Event.future_events.page(params[:page])
  end
end
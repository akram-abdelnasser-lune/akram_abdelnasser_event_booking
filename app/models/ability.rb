class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    can :read, Event
    can :create, Event

    can :update, Event do |event|
      event.creator_id == user.id && event.start_time > Time.now
    end

    can :destroy, Event do |event|
      event.creator_id == user.id && event.start_time > Time.now
    end

    can :create, Booking do |booking|
      booking.event.start_time > Time.now &&
      booking.event.creator_id != user.id &&
      !user.bookings.exists?(event_id: booking.event_id)
    end

    can :update, Booking do |booking|
      booking.user_id == user.id && booking.event.start_time > Time.now
    end

    can :destroy, Booking do |booking|
      booking.user_id == user.id && booking.event.start_time > Time.now
    end
  end
end
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    can :read, Event
    can :create, Event
    can :update, Event do |event|
      event.creator_id == user.id && event.start_time > Time.now 
    end

    can :destroy, Event do |event|
      event.creator_id == user.id && event.start_time > Time.now
    end
  end
end
class Event < ApplicationRecord
  include Ticketable

  # VALIDATIONS #
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :location, presence: true
  validates :start_time, presence: true
  validates :total_tickets, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :start_time_must_be_in_future

  # SCOPES #
  scope :future_events, -> { where('start_time > ?', Time.now) }

  # ASSOCIATIONS #
  belongs_to :creator, class_name: "User"
  has_many :bookings, dependent: :destroy
  has_many :booked_users, through: :bookings, source: :user

  before_create :set_remaining_tickets

  def book_tickets(user, number_of_tickets)
    with_lock do
      if remaining_tickets >= number_of_tickets
        self.remaining_tickets -= number_of_tickets
        if save
          begin
            bookings.create!(user: user, number_of_tickets: number_of_tickets)
          rescue ActiveRecord::RecordInvalid
            errors.add(:base, "Failed to book tickets due to a save error")
            raise ActiveRecord::Rollback
          end
        else
          errors.add(:base, "Failed to save updated ticket count")
          raise ActiveRecord::Rollback
        end
      else
        errors.add(:base, "Not enough tickets available")
        raise ActiveRecord::Rollback
      end
    end
    errors.any? ? false : true
  rescue StandardError => e
    errors.add(:base, "Unexpected error occurred: #{e.message}")
    false
  end
  

  private

  def set_remaining_tickets
    self.remaining_tickets = total_tickets
  end

  def start_time_must_be_in_future
    if start_time.present? && start_time <= Time.now
      errors.add(:start_time, "must be in the future")
    end
  end
end
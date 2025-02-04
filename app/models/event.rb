class Event < ApplicationRecord
  include Ticketable

  # VALIDATIONS #
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :location, presence: true
  validates :start_time, presence: true
  validates :total_tickets, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :remaining_tickets, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validate :start_time_must_be_in_future
  validate :validate_total_tickets

  # SCOPES #
  scope :future_events, -> { where('start_time > ?', Time.now) }

  # ASSOCIATIONS #
  belongs_to :creator, class_name: "User"
  has_many :bookings, dependent: :destroy
  has_many :booked_users, through: :bookings, source: :user

  # CALLBACKS #
  before_create :set_remaining_tickets

  private

  def set_remaining_tickets
    self.remaining_tickets = total_tickets
  end

  def start_time_must_be_in_future
    if start_time.present? && start_time <= Time.now
      errors.add(:start_time, "must be in the future")
    end
  end

  def validate_total_tickets
    if total_tickets < remaining_tickets
      errors.add(:total_tickets, "must be greater than or equal to the remaining tickets")
    end
  end
end
class Event < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :location, presence: true
  validates :start_time, presence: true
  validates :total_tickets, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :start_time_must_be_in_future

  private

  def start_time_must_be_in_future
    if start_time.present? && start_time <= Time.now
      errors.add(:start_time, "must be in the future")
    end
  end
end
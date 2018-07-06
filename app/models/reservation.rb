class Reservation < ApplicationRecord
  belongs_to :table
  validates :table, :from, :to, presence: true

  validate :restaurant_schedule
  validate :reservation_overlap


  delegate :restaurant, to: :table


  private

  def reservation_overlap
    if table.reservations.where("(reservations.from, reservations.to) OVERLAPS (?, ?)", from, to).any?
      errors.add(:reservations, 'Reservation not available for this time.')
    end
  end

  def restaurant_schedule
    restaurant_from = from.change hour: restaurant.from_hour, minutes: restaurant.from_minutes
    restaurant_to   = from.change hour: restaurant.to_hour, minutes: restaurant.to_minutes

    schedule = IceCube::Schedule.new(restaurant_from, end_time: restaurant_to)
    schedule.add_recurrence_rule IceCube::Rule.weekly.day(restaurant.weeks.map(&:to_sym))
    unless schedule.occurring_between?(from, to)
      errors.add(:reservations, 'Reservation out of restaurant schedule.')
    end
  end
end

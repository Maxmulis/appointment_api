class Appointment < ApplicationRecord
  belongs_to :realtor
  validate :min_48_hours_in_the_future

  def strftime
    time.strftime("%d/%m/%Y %H:%M")
  end

  def min_48_hours_in_the_future
    if time < DateTime.current.next_weekday + 1
      errors.add(:time, "must be at least 48 hours in the future (weekends do not count)")
    end
  end
end

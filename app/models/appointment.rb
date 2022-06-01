class Appointment < ApplicationRecord
  belongs_to :realtor
  validate :min_48_hours_in_the_future, :on_weekday, :during_work_hours
  validates :latitude, :longitude, :address, :time, :name, :phone, presence: true

  def strftime
    time.strftime("%d/%m/%Y %H:%M")
  end

  def min_48_hours_in_the_future
    if time < DateTime.current.next_weekday + 1
      errors.add(:time, "must be at least 48 hours in the future (weekends do not count)")
    end
  end

  def on_weekday
    errors.add(:time, "must be on a weekday (MON-FRI)") unless time.on_weekday?
  end

  def during_work_hours
    errors.add(:time, "must be between 8am and 6pm") unless time.hour >= 9 && time.hour <= 18
  end
end

class Appointment < ApplicationRecord
  belongs_to :realtor

  def strftime
    time.strftime("%e/%d/%Y %H:%M")
  end
end

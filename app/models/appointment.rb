class Appointment < ApplicationRecord
  belongs_to :realtor

  def strftime
    time.strftime("%d/%m/%Y %H:%M")
  end
end

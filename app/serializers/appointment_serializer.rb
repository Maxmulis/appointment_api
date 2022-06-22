class AppointmentSerializer < ActiveModel::Serializer
  attributes :lat, :lng, :address, :time
  belongs_to :realtor
  belongs_to :seller

  def time
    object.time.strftime("%d/%m/%Y %H:%M")
  end
end

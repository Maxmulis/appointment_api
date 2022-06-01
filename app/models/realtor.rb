class Realtor < ApplicationRecord
  has_many :appointments

  geocoded_by :address
  # after_validation :geocode, if: lambda{ |obj| obj.address_changed? }

  def self.closest_to(latlng)
    Realtor.near(latlng, 20, units: :km).first
  end
end

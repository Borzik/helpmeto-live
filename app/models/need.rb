class Need < ApplicationRecord
  belongs_to :user
  attr_writer :lc_lat, :lc_lng
  before_validation :set_location

  scope :within_10km_from, -> (location) {
    where(%{
     ST_Distance(location, '%s') < %d
    } % [location, 10000])
  }

  def set_location
    self.location = "POINT(#{@lc_lng} #{@lc_lat})"
  end

  def lc_lat
    location&.latitude
  end
  def lc_lng
    location&.longitude
  end
end
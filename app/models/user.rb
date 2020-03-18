class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  before_create :set_sid
  validates :name, presence: true, on: :update
  validates :bio, presence: true, on: :update
  validates :location, presence: { message: 'please set a marker near your location' }, on: :update, if: :volunteer?

  enum kind: { guest: 0, recipient: 1, volunteer: 2 }

  has_one :need, dependent: :destroy
  has_many :offers
  attr_writer :lc_lat, :lc_lng
  before_validation :set_location

  def lc_lat
    location&.latitude
  end
  def lc_lng
    location&.longitude
  end

  private
  def set_sid
    self.sid = SecureRandom.alphanumeric(8)
  end

  def set_location
    return if !@lc_lat || !@lc_lng
    self.location = "POINT(#{@lc_lng} #{@lc_lat})"
  end
end

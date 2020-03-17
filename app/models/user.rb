class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  before_create :set_sid
  validate :account_complete, on: :update

  enum kind: { guest: 0, recipient: 1, volunteer: 2 }

  has_one :need, dependent: :destroy
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

  def account_complete
    if !guest?
      errors.add(:name, 'required') unless name.present?
      errors.add(:bio, 'required') unless bio.present?
    end
  end

  def set_location
    return if !@lc_lat || !@lc_lng
    self.location = "POINT(#{@lc_lng} #{@lc_lat})"
  end
end

class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  before_create :set_sid

  private
  def set_sid
    self.sid = SecureRandom.alphanumeric(8)
  end
end

class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  before_create :set_sid
  validate :account_complete, on: :update

  enum kind: { guest: 0, recipient: 1, volunteer: 2 }

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
end

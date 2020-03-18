class Offer < ApplicationRecord
  belongs_to :user
  belongs_to :need

  validates :user_id, uniqueness: { scope: :need_id, message: 'offer has already been sent' }
  validates :message, presence: true
  validates :contact_info, presence: true
end

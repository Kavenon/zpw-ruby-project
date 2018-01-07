class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :user_id, presence: true
  validates :event_id, presence: true
  validates :seat, presence: true
  validates :price, presence: true

end

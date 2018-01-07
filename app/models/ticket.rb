class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :user_id, presence: true
  validates :event_id, presence: true
  validates :seat, presence: true,  numericality: { only_integer: true }
  validates :price, presence: true,  numericality: true

end

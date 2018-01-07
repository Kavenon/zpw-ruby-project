class Event < ApplicationRecord

  validates :name,  presence: true, length: { minimum: 3, maximum: 100 }
  validates :desc,  presence: true, length: { minimum: 50, maximum: 1000 }
  validates :price,  presence: true, numericality: true
  validates :required_age, numericality: { only_integer: true }, :allow_nil => true
  validates :free_seats,  presence: true, numericality: { only_integer: true }
  has_attached_file :poster
  validates_attachment_content_type :poster, content_type: /\Aimage/

  validates_date :date, on_or_after: lambda { Date.current }

  has_many :tickets, dependent: :destroy

end

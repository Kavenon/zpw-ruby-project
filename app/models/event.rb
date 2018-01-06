class Event < ApplicationRecord

  validates :name,  presence: true
  validates :desc,  presence: true
  validates :price,  presence: true
  validates :free_seats,  presence: true
  has_attached_file :poster
  validates_attachment_content_type :poster, content_type: /\Aimage/

  validates_date :date, on_or_after: lambda { Date.current }

end

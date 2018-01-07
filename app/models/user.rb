class User < ApplicationRecord
  validates :name,  presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  has_secure_password
  validates_date :birthday, on_or_before: lambda { Date.current }
  validates :password, presence: true, length: { minimum: 6 }, :if => :password

  has_many :tickets, dependent: :destroy

end

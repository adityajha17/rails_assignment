class User < ApplicationRecord
  before_save { self.email = email.downcase }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  validates :name, presence: true, length: { maximum: 60 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  validates :age, format: {with: /[0-9]+/, message: "Must be integer"}
  validates :phone, format: {with: /\A\d{10}\z/, message: "Must be a 10 digit valid number"}

end

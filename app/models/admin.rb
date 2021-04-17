class Admin < ApplicationRecord
  validates :phone, presence: true,
            format: {with: /\A\d{10}\z/, message: "Phone number should be valid"}
  validates :otp, presence: true,
            format: {with: /\A\d{6}\z/, message: "Otp should be 6 digit number"}
end

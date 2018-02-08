class Customer < ApplicationRecord
  has_many :order

  validates :email, uniqueness: true, on: :create
  validates :email, presence: true
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }

end

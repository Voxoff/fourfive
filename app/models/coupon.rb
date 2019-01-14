class Coupon < ApplicationRecord
  has_many :carts
  validates :code, :discount, presence: true
end

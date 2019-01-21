class Coupon < ApplicationRecord
  has_many :carts
  validates :code, :discount, presence: true

  def percent
    discount.to_f / 100
  end
end

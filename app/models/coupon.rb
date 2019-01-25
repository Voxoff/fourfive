class Coupon < ApplicationRecord
  has_many :carts
  validates :code, presence: true
  validates :discount, presence: true, numericality: { only_integer: true }

  before_validation {self.code = self.code.upcase! }

  def percent
    discount.to_f / 100
  end
end

class Coupon < ApplicationRecord
  has_many :carts
  validates :code, presence: true, uniqueness: true
  validates :discount, presence: true, numericality: { only_integer: true }

  include ActiveAdmin::Callbacks
  before_validation { self.code = self.code.upcase }

  def percent
    discount.to_f / 100
  end

  def amount
    carts.orders.map(&:amount).reduce(:+)&.*(percent) || "0"
  end

  def used?
    !carts.orders.empty?
  end

  def activate
    update(active: true)
  end

  def deactivate
    update(active: false)
  end
end

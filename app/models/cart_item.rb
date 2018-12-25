class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  # belongs_to :strength

  after_save :check_quantity

  def line_cost
    quantity * product.price
  end

  def check_quantity
    destroy if quantity.zero?
  end
end

class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  validates :quantity, presence: true
  # belongs_to :strength
  def line_cost
    self.quantity * self.product.price
  end
end

class CartItem < ApplicationRecord
  belongs_to :cart, dependent: :destroy
  belongs_to :product, dependent: :destroy
  validates :quantity, presence: true
  # belongs_to :strength
  def line_cost
    quantity * product.price
  end
end

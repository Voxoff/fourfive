class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 100 }

  def line_cost
    quantity * product.price
  end

  def update_or_destroy(change)
    q = quantity + change
    q.zero? ? destroy : update(quantity: q)
  end

  def self.data_hash_for_month(month)
    joins(:cart, product: :product_group)
      .merge(Cart.orders.month_of(month))
      .group(:product_id)
      .count
  end

  # how to refactor but keep one sql query?
  def self.data_hash_for_total
    joins(:cart, product: :product_group)
      .merge(Cart.orders)
      .group(:product_id)
      .count
  end
end

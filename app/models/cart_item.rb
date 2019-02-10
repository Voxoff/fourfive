class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 100 }

  # scope :weeks_ago, ->(weeks_ago) { where('updated_at >= :weeks_ago', weeks_ago: weeks_ago.day.ago) }
  delegate :description, to: :product

  def unit_amount
    product.price
  end

  def line_cost
    quantity * product.price
  end

  def update_or_destroy(change)
    q = self.quantity + change
    q.zero? ? self.destroy : self.update(quantity: q)
  end
end

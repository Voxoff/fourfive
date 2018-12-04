class Cart < ApplicationRecord
  # validates :active, uniqueness: { scope: user_id }, if: :active?
  belongs_to :user, required: false
  has_many :cart_items

  def amount
    self.cart_items.map{|i| i.product.price}.reduce(:+)
  end
end

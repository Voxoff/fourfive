class Cart < ApplicationRecord
  # validates :active, uniqueness: { scope: user_id }, if: :active?
  belongs_to :user, required: false
  has_many :cart_items, dependent: :destroy

  scope :orders, -> { where(active: false)}
  scope :has_user, -> { where(user: !nil ) }
  # scope :last24, -> { where("update")}

  def amount
    self.cart_items.map{|i| i.product.price}.reduce(:+)
  end

  def checkout
    self.update(active: false)
    user_id = self.user_id
    self.class.create!(user_id: user_id)
  end
end

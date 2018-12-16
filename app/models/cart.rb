class Cart < ApplicationRecord
  # validates :active, uniqueness: { scope: user_id }, if: :active?
  belongs_to :user, required: false
  has_many :cart_items, dependent: :destroy
  has_one :address, dependent: :destroy
  # validates :status, inclusion: { in: %w(active inactive pending) } #not used anywhere yet

  scope :orders, -> { where(active: false) }
  scope :has_user, -> { where(user: !nil) }
  scope :last24, -> { where('updated_at >= :last24', last24: 1.day.ago) }
  scope :old, -> { where('updated_at <= :thirty_days_ago', thirty_days_ago: 30.days.ago) }

  def amount
    self.cart_items.includes(:product).map |i| i.product.price * i.quantity }.reduce(:+)
  end

  def quantity
    self.cart_items.map(&:quantity).reduce(:+)
  end

  def checkout
    self.update(active: false)
    user_id = self.user_id
    self.class.create!(user_id: user_id)
  end
end

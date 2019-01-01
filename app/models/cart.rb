class Cart < ApplicationRecord
  belongs_to :user, required: false
  has_many :cart_items, dependent: :destroy
  has_one :address, dependent: :destroy

  validates :order_id, numericality: {integer: true }, allow_nil: true, uniqueness: true

  scope :orders, -> { where(active: false) }
  scope :has_user, -> { where(user: !nil) }
  scope :last24, -> { where('updated_at >= :last24', last24: 1.day.ago) }
  scope :old, -> { where('updated_at <= :thirty_days_ago', thirty_days_ago: 30.days.ago) }
  scope :fulfilled, -> { where(fulfillment: true) }

  def amount
    cart_items.includes(:product).map { |i| i.product.price * i.quantity }.reduce(:+)
  end

  def quantity
    cart_items.map(&:quantity).reduce(:+)
  end

  def checkout
    order_id = Cart.maximum(:order_id).to_i + 1
    update(active: false, order_id: order_id)
    user_id = self.user_id
    self.class.create!(user_id: user_id)
  end

  def basket
    cart_items.includes(:product).map {|item| "#{item.product.specific_name} x #{item.quantity}"}
  end

  def checkout_time
    updated_at.strftime('%A, %b %d')
  end

  def count
    cart_items.sum(&:quantity)
  end

  # at the moment if you delete a user, the cart will update to have no user. This is important for real users that delete themselves.
  #But for guests there is just a hanging cart.
end

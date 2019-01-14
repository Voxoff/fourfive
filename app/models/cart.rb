class Cart < ApplicationRecord
  belongs_to :user, required: false
  has_many :cart_items, dependent: :destroy
  has_one :address, dependent: :destroy
  has_one :coupon
  # belongs_to :coupon, required: false
  mount_uploader :receipt, PhotoUploader

  validates :order_id, numericality: {integer: true }, allow_nil: true, uniqueness: true

  scope :orders, -> { where(active: false) }
  scope :not_orders, -> { where(active: true)}
  scope :has_user, -> { where(user: !nil) }
  scope :last24, -> { where('updated_at >= :last24', last24: 1.day.ago) }
  scope :old, -> { where('updated_at <= :thirty_days_ago', thirty_days_ago: 30.days.ago) }
  scope :fulfilled, -> { where(fulfillment: true) }
  scope :unfulfilled, -> { where(fulfillment: false, active: false)}



  def amount
    amount = cart_items.includes(:product).map { |i| i.product.price * i.quantity }.reduce(:+)
    coupon ? calc_discount(amount) : amount
  end

  def quantity
    cart_items.map(&:quantity).reduce(:+)
  end

  def checkout
    order_id = Cart.maximum(:order_id).to_i + 1
    update(active: false, order_id: order_id, checked_out_at: Time.now)
    user_id = self.user_id
    self.class.create!(user_id: user_id)
  end

  def basket
    cart_items.map {|item| "#{item.product.specific_name} x #{item.quantity}"}
  end

  def checkout_time
    checked_out_at ? checked_out_at.strftime('%A, %b %d') : updated_at.strftime('%A, %b %d')
  end

  def count
    cart_items.sum(&:quantity)
  end

  def fulfill!
    update(fulfillment: true)
  end

  def self.revenue
    orders.includes(cart_items: :product).map(&:cart_items).flatten.map { |i| i.product.price * i.quantity }.reduce(:+)
  end

  def calc_discount(amount)
    amount * (1 - (coupon.discount * 0.01))
  end
  # at the moment if you delete a user, the cart will update to have no user. This is important for real users that delete themselves.
  # But for guests there is just a hanging cart.
end

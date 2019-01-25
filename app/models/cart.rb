class Cart < ApplicationRecord
  belongs_to :user, required: false
  belongs_to :coupon, required: false
  has_many :cart_items, dependent: :destroy
  has_one :address, dependent: :destroy

  mount_uploader :receipt, PhotoUploader

  validates :order_id, numericality: {integer: true }, allow_nil: true, uniqueness: true

  scope :orders, -> { where(active: false) }
  scope :not_orders, -> { where(active: true)}
  scope :has_user, -> { where(user: !nil) }
  scope :last24, -> { where('updated_at >= :last24', last24: 1.day.ago) }
  scope :old, -> { where('updated_at <= :thirty_days_ago', thirty_days_ago: 30.days.ago) }
  scope :fulfilled, -> { where(fulfillment: true) }
  scope :unfulfilled, -> { where(fulfillment: false, active: false)}
  # scope :weeks_ago, ->(weeks_ago) { where(checked_out_at: weeks_ago.week.ago..(weeks_ago - 1).week.ago) }

  def self.weeks_ago(weeks)
    where(checked_out_at: weeks.week.ago..(weeks - 1).week.ago)
  end

  def self.month_of(month)
    month = DateTime.parse(month)
    range = month..month.next_month
    where(checked_out_at: range)
  end

  # to cope with SQL query efficieny
  def amount(with_includes = true)
    active_record_relation = with_includes ? cart_items.includes(:product) : cart_items
    amount = active_record_relation.map { |i| i.product.price * i.quantity }.reduce(:+)
    coupon ? calc_discount(amount) : amount
  end

  # def amount
  #   amount = cart_items.includes(:product).map { |i| i.product.price * i.quantity }.reduce(:+)
  #   coupon ? calc_discount(amount) : amount
  # end

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

  private

  def calc_discount(amount)
    amount * (1 - (coupon.discount * 0.01))
  end
end

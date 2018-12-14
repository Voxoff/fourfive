class Cart < ApplicationRecord
  # validates :active, uniqueness: { scope: user_id }, if: :active?
  belongs_to :user, required: false
  has_many :cart_items, dependent: :destroy
  has_one :address
  validates :status, inclusion: { in: %w(active inactive pending) }

  scope :orders, -> { where(active: false)}
  scope :has_user, -> { where(user: !nil ) }
  # scope :last24, -> { where("update")}

  def amount
    self.cart_items.map{|i| i.product.price * i.quantity}.reduce(:+)
  end

  def quantity
    self.cart_items.map{|i| i.quantity}.reduce(:+)
  end

  def checkout
    self.update(active: false)
    user_id = self.user_id
    self.class.create!(user_id: user_id)
  end

  # def coupons
  #   ["DOMDAY", "COUPON"]
  # end

  # def verify_coupon?(coupon, amount)
  #     if coupons.include?(coupon)
  #       amount = amount.to_f * 0.9
  #     elsif !coupons.include?(coupon)
  #       flash[:notice] = "That coupon code did not work"
  #       return redirect_to new_cart_payment_path
  #     end
  #   end
  #   amount
  # end
end

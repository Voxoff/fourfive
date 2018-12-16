module CartControllable
  extend ActiveSupport::Concern
  def find_cart
    user = current_or_guest_user
    @cart = Cart.find_by(user_id: user.id, active: true)
  end

  def find_or_create_cart
    user = current_or_guest_user
    @cart = Cart.find_by(user_id: user.id, active: true)
    @cart = Cart.create(user_id: user.id, active: true) if @cart.nil?
    @cart
  end
end

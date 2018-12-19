class CartsController < ApplicationController
  include CartControllable
  before_action :find_cart

  def show
    pundit_placeholder
    @cart_items = @cart.cart_items.includes(:product)
    check_empty_cart
  end

   def pundit_placeholder
    return unless current_or_guest_user != @cart.user || params[:id].to_i != @cart.id

    flash[:notice] = "You do not have access to this cart"
    return redirect_to root_path
  end

    def check_empty_cart
    return unless @cart_items.empty?

    flash[:notice] = "You need to put items in your cart in order to buy them!"
    return redirect_to root_path
  end
end

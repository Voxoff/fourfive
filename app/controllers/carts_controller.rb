class CartsController < ApplicationController
  include CartControllable
  before_action :find_cart

  include PunditControllable
  before_action :pundit_placeholder, only: :show

  def show
    pundit_placeholder
    @cart_items = @cart.cart_items.includes(product: :product_group).sort_by{ |i| i.product.name }
    check_empty_cart
  end

  def check_empty_cart
    return unless @cart_items.empty?

    flash[:notice] = "You need to put items in your cart in order to buy them!"
    return redirect_to root_path
  end
end

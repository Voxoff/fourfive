class CartsController < ApplicationController
  include CartControllable
  before_action :find_cart

  include PunditControllable
  before_action :pundit_placeholder, only: :show

  def show
    pundit_placeholder
    @cart_items = @cart.cart_items.includes(product: :product_group).sort_by{ |i| i.product.name }
    check_empty_cart
    @coupon_code = @cart.coupon&.code
  end

  def check_empty_cart
    return unless @cart_items.empty?

    flash[:notice] = "You need to put items in your cart in order to buy them!"
    return redirect_to root_path
  end

  def coupon
    @coupon = Coupon.find_by(code: params[:cart][:coupon]&.upcase)
    if params[:cart][:coupon].empty?
      flash[:notice] = "Please enter a coupon code."
      return redirect_to cart_path(@cart)
    elsif @coupon.nil?
      flash[:notice] = "There is no coupon with that code."
      return redirect_to cart_path(@cart)
    elsif !@coupon.active?
      flash[:notice] = "Your coupon code is no longer active."
      return redirect_to cart_path(@cart)
    end
    @cart.update(coupon: @coupon)
    flash[:notice] = "Your coupon has been added."
    return redirect_to cart_path(@cart)
  end
end

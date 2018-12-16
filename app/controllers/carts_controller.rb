class CartsController < ApplicationController
  def show
    @cart = Cart.find(params[:id])
    @cart_items = @cart.cart_items if @cart
    return unless @cart_items.empty?

    flash[:notice] = "You need to put items in your cart first!"
    redirect_to root_path
  end
end

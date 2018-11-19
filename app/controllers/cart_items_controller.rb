class CartItemsController < ApplicationController
  def create
    # raise
    @cart = Cart.find(cart_items_params[:cart_id])
    @cart_item = CartItem.new(cart_id: cart_items_params[:cart_id])
    @cart_item.product = Product.where(name: cart_items_params[:product_name]).first
    @cart_item.strength = Strength.where(strength: cart_items_params[:strength]).first
    if @cart_item.save
      flash[:notice] = "That's been added to your cart!"
    else
      flash[:notice] = "There was an error. Sorry!"
    end
    redirect_back(fallback_location: cart_path(@cart.id))
  end

  private

  def cart_items_params
    params.require(:cart_item).permit(:cart_id, :strength, :product_name)
  end
end

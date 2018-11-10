class CartItemsController < ApplicationController
  def create
    # raise
    @cart = Cart.find(cart_items_params[:cart_id])
    if CartItem.create(cart_items_params)
      flash[:notice] = "That's been added to your cart!"
    end    
    redirect_back(fallback_location: cart_path(@cart.id))
  end

  private

  def cart_items_params
    params.require(:cart_item).permit(:cart_id, :strength, :quantity)
  end
end

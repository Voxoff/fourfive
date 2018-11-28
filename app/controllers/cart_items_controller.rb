class CartItemsController < ApplicationController
  def create
    # raise
    @cart = Cart.find(cart_params[:cart_id])
    @cart_item = CartItem.new(cart_params)
      @cart_item.product = Product.find(cart_items_params[:product])
      @cart_item.strength = Strength.where(strength: cart_items_params[:strength]).first
    if @cart_item.save
      flash[:notice] = "That's been added to your cart!"
    else
      flash[:notice] = "There was an error. Sorry!"
    end
    redirect_back(fallback_location: cart_path(@cart.id))
  end

  private

  #refactor
  def cart_items_params
    params.require(:cart_item).permit(:strength, :product)
  end

  def cart_params
    params.permit(:cart_id)
  end
end

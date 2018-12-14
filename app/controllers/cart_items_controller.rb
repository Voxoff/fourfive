class CartItemsController < ApplicationController
  def create
    @cart = Cart.find(cart_params[:cart_id])
    @cart_item = @cart.cart_items.find {|i| i.product.id == cart_params[:product_id].to_i}
    if @cart_item
      @cart_item.quantity = @cart_item.quantity + params[:quantity].to_i
    else
      @cart_item = CartItem.new(cart_params)
    end
    if @cart_item.save
      flash[:notice] = "That's been added to your cart!"
    else
      flash[:notice] = "There was an error. Sorry!"
    end
    redirect_back(fallback_location: cart_path(@cart.id))
  end

  private

  def cart_items_params
    params.require(:cart_item).permit(:strength, :product)
  end

  def cart_params
    params.permit(:cart_id, :product_id, :quantity)
  end
end

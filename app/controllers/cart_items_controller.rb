class CartItemsController < ApplicationController
  def create
    @cart = Cart.find(cart_params[:cart_id])
    @cart_item =  @cart.cart_items.find {|i| i.product.id == cart_params[:product_id].to_i}
    if @cart_item
      new_quantity = @cart_item.quantity + params[:quantity].to_i
      @cart_item.quantity = new_quantity
    else
      @cart_item = CartItem.new(cart_params)
      @cart_item.product = Product.find(cart_params[:product_id])
      @cart_item.quantity = cart_params[:quantity]
      # @cart_item.strength = Strength.where(strength: cart_items_params[:strength]).first
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

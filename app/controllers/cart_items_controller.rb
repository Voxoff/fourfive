class CartItemsController < ApplicationController
  before_action :find_cart, only: [:create]

  def create
    pundit_placeholder()
    @cart_item = @cart.cart_items.find {|i| i.product.id == cart_params[:product_id].to_i}
    if @cart_item
      @cart_item.quantity += params[:quantity].to_i
    else
      @cart_item = CartItem.new(cart_params)
    end
    flash[:notice] =  @cart_item.save ? "That's been added to your cart!" : "There was an error. Sorry!"
    redirect_back(fallback_location: cart_path(@cart.id))
  end

  def pundit_placeholder
    # this shoudl really be done via pundit
    if current_or_guest_user != @cart.user
      flash[:notice] = "You do not have access to this cart"
      return redirect_to root_path
    end
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart = cart_item.cart
    CartItem.destroy(cart_item.id)
    flash[:notice] = "That's been removed from your cart."
    return redirect_to new_cart_payment_path(cart)
  end

  private

  def find_cart
    @cart = Cart.find(cart_params[:cart_id])
  end

  def cart_items_params
    params.require(:cart_item).permit(:strength, :product)
  end

  def cart_params
    params.permit(:cart_id, :product_id, :quantity)
  end
end

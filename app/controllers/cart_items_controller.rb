class CartItemsController < ApplicationController
  before_action :find_cart, only: [:create, :update]

  def create
    pundit_placeholder
    if params[:size].present?
      @product = params[:tincture].present? ? Product.find_by(p_params) : Product.find_by(s_params)
    else
      @product = Product.find_by(name: "cbd_capsules")
    end
    @cart_item = @cart.cart_items.includes(:product).find { |i| i.product.id == @product.id }
    if @cart_item
      @cart_item.quantity += params[:quantity].to_i
    else
      @cart_item = CartItem.new(cart_params)
      @cart_item.product = @product
    end
    flash[:notice] = @cart_item.save ? "That's been added to your cart!" : "There was an error. Sorry!"
    redirect_back(fallback_location: cart_path(@cart.id))
  end

  def pundit_placeholder
    return unless current_or_guest_user != @cart.user

    flash[:notice] = "You do not have access to this cart"
    return redirect_to root_path
  end

  def update
    cart_item = CartItem.find(params[:id])
    change = params[:quantity].to_i
    if @cart.cart_item_ids.include?(cart_item.id)
      quantity = cart_item.quantity + change
      quantity == 0 ? cart_item.destroy : cart_item.update(quantity: quantity)
      flash[:notice] = change.positive? ? "That's been added to your cart." : "That's been removed from your cart."
    end
    redirect_to cart_path(@cart)
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart = cart_item.cart
    cart_item.destroy
    flash[:notice] = "That's been removed from your cart."
    return redirect_to cart_path(cart)
  end

  private

  def find_cart
    @cart = Cart.find(params[:cart_id])
  end

  def p_params
    params.permit(:size, :tincture)
  end

  def s_params
    params.permit(:size)
  end

  def cart_params
    params.permit(:cart_id, :quantity, :product_id)
  end
end

class CartItemsController < ApplicationController
  before_action :find_cart, only: [:create]

  def create
    pundit_placeholder
    # @product = Product.find(product_id_params[:product_id])
    if product_params[:size].present?
    @product = Product.find_by(product_params)
    else
      @product = Product.find_by(name: "cbd_capsules")
    end
    @cart_item = @cart.cart_items.includes(:product).find { |i| i.product.id == @product.id }
    if @cart_item
      @cart_item.quantity += cart_params[:quantity].to_i
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

  def destroy
    cart_item = CartItem.find(params[:id])
    cart = cart_item.cart
    # raise
    cart_item.destroy
    flash[:notice] = "That's been removed from your cart."
    return redirect_to cart_path(cart)
  end

  private

  def find_cart
    @cart = Cart.find(cart_params[:cart_id])
  end

  def cart_items_params
    params.require(:cart_item).permit(:strength, :product)
  end

  def product_params
    params.permit(:size, :tincture)
  end

  def product_id_params
    params.permit(:product_id)
  end

  def cart_params
    params.permit(:cart_id, :quantity, :product_id)
  end
end

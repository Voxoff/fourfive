class CartItemsController < ApplicationController
  include CartControllable
  before_action :find_or_create_cart, only: :create
  before_action :find_cart, only: :update
  include PunditControllable
  before_action :pundit_placeholder, only: :create

  def create
    @product = find_product
    @cart_item = @cart.cart_items.includes(:product).find { |i| i.product.id == @product.id }
    if @cart_item
      @cart_item.quantity += params[:quantity].to_i
    else
      @cart_item = CartItem.new(cart_params)
      @cart_item.product = @product
      @cart_item.cart = @cart
    end
    flash[:notice] = @cart_item.save ? "That's been added to your cart!" : "There was an error. Sorry!"
    authorize @cart_item
    redirect_back(fallback_location: cart_path(@cart.id))
  end

  def update
    cart_item = CartItem.find(params[:id])
    change = params[:quantity].to_i
    if cart_item.cart == @cart
      cart_item.update_or_destroy(change)
      flash[:notice] = change.positive? ? "That's been added to your cart." : "That's been removed from your cart."
    end
    authorize @cart_item
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

  def find_product
    if params[:size].present? && params[:tincture].present?
      @product = Product.find_by(p_params(:size, :tincture))
    elsif params[:size].present?
      @product = Product.find_by(p_params(:size))
    else
      @product = Product.find_by(name: "cbd_capsules")
    end
    @product
  end

  def p_params(*args)
    params.permit(*args)
  end

  def cart_params
    params.permit(:cart_id, :quantity, :product_id)
  end
end

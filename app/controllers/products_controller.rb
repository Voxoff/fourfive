class ProductsController < ApplicationController
  include CartControllable
  before_action :find_or_create_cart

  def show
    @product = Product.friendly.find(params[:id])
    @cart_item = CartItem.new
  end
end

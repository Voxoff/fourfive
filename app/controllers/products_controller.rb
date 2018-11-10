class ProductsController < ApplicationController
    include CartControllable
    before_action :get_cart

  def index
    @products = Product.all
    @cart_item = CartItem.new
  end

  def show
    @product = Product.friendly.find(params[:id])
  end

  def create
    raise
  end
end

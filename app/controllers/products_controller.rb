class ProductsController < ApplicationController
  include CartControllable
  before_action :find_or_create_cart

  def show
    @product = Product.friendly.find(params[:id])
    @help = @product.help
    @help_count = (@help.count / 2 - 1)
    @ingr = @product.ingredients
    @ingr_count = (@ingr.count / 2 - 1)
    @price = @product.price.to_i
    @cart_item = CartItem.new
  end
end

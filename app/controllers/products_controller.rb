class ProductsController < ApplicationController
  include CartControllable
  before_action :find_cart

  def show
    @product = Product.find_by(name: params[:name]) or not_found
    @group = @product.product_group
    @sizes = @product.balm? ? ["Small balm", "Large balm"] : ["Lower (500mg)", "Medium (1000mg)", "Higher (2000mg)"]
    @tinctures = %w[Natural Orange] # @tinctures = Product.all.collect(&:tincture).uniq.compact
    @specific_product = @product.image_name
    @readable_name = @product.readable_name
    @ingr = @group.ingredients
    @price = @product.price
    @cart_item = CartItem.new
  end
end

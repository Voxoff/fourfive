class ProductsController < ApplicationController
  include CartControllable
  before_action :find_or_create_cart

  def show
    @product = Product.friendly.find(params[:id])
    @group = @product.product_group
    if @product.balm?
      @sizes = ["Small balm", "Large balm"]
    else
      @sizes = ["Lower (500mg)","Medium (1000mg)","Higher (2000mg)"]# @strengths = Product.all.collect(&:size).uniq.compact
    end
    @tinctures = %w[Natural Orange] # @tinctures = Product.all.collect(&:tincture).uniq.compact
    @specific_product = @product.image_name if @product.oil?
    @specific_product = "#{@product.size} balm (30ml / 300mg)" if @product.balm?
    @help = @group.help
    @help_count = (@help.count / 2 - 1)
    @ingr = @group.ingredients
    @ingr_count = (@ingr.count / 2 - 1)
    @price = @product.price
    @cart_item = CartItem.new
  end
end

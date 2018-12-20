class ProductsController < ApplicationController
  include CartControllable
  before_action :find_or_create_cart

  def show
    @product = Product.friendly.find(params[:id])
    if @product.balm?
      @sizes = %w[Small Large]
    else
      @sizes = %w[500mg 1000mg 2000mg] # @strengths = Product.all.collect(&:size).uniq.compact
    end
    @tinctures = %w[Natural Orange] # @tinctures = Product.all.collect(&:tincture).uniq.compact
    @specific_product = "#{@product.tincture} #{@product.size}" if @product.oil?
    @specific_product = "#{@product.size} balm" if @product.balm?
    @help = @product.help
    @help_count = (@help.count / 2 - 1)
    @ingr = @product.ingredients
    @ingr_count = (@ingr.count / 2 - 1)
    @price = @product.price
    @cart_item = CartItem.new
  end
end

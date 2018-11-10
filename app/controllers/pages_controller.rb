class PagesController < ApplicationController
  include CartControllable
  before_action :get_cart
  def home
    @products = Product.all
    @cart_item = CartItem.new
  end

  def about
  end

  def contact
  end

  def education
  end

  def privacy_policy
  end
end

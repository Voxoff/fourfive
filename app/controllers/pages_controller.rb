class PagesController < ApplicationController
  include CartControllable
  before_action :get_cart
  def home
    @disable_stripe = true
    @user = current_or_guest_user
    @products = [Product.find(2), Product.find(4), Product.find(6)]
    @cart_item = CartItem.new
    @reviews = Review.all.take(3)
  end

  def about
  end

  def education
  end

  def privacy_policy
  end

  private

  def checkout_params
    params.permit(:resource_path)
  end
end

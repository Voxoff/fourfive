class PagesController < ApplicationController
  include CartControllable
  before_action :get_cart
  def home
    @disable_stripe = true
    @user = current_or_guest_user
    @products = [Product.where(name: 'cbd oils'), Product.where(name: 'cbd balms'), Product.where(name: 'cbd capsules')]
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

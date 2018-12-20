class PagesController < ApplicationController
  include CartControllable
  before_action :find_cart
  def home
    @disable_stripe = @disable_top_margin = @alert_no_margin = true
    @user = current_or_guest_user
    @products = [Product.find_by(name: 'cbd_oils'),
                 Product.find_by(name: 'cbd_balms'),
                 Product.find_by(name: 'cbd_capsules')]
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

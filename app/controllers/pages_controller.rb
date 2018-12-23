class PagesController < ApplicationController
  include CartControllable
  before_action :find_cart
  def home
    @disable_stripe = @disable_top_margin = @alert_no_margin = true
    @user = current_or_guest_user
    @product_groups = ProductGroup.all
    @cart_item = CartItem.new
    @reviews = Review.all.take(3)
  end

  def about
  end

  def education
  end

  def privacy_policy
  end
end

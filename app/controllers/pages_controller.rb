class PagesController < ApplicationController
  include CartControllable
  before_action :find_cart

  def home
    @disable_stripe = @disable_top_margin = @alert_no_margin = true
    @user = current_or_guest_user
    @product_groups = ProductGroup.includes(:products).order(:id)
    @cart_item = CartItem.new
    # @reviews = Review.all.take(3)
  end

  def about
  end

  def education
  end

  def privacy_policy
  end

  def terms_and_conditions
  end
end

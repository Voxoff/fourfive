class PagesController < ApplicationController
  def home
    # @cart = find_cart { create_cart }
    @products = Product.all
    @user = User.new
    @cart = Cart.find_by(user_id: current_user&.id, active: true)
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

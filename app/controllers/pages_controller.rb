class PagesController < ApplicationController
  before_action :get_cart
  def home
    @products = Product.all
    @cartitem = CartItem.new
  end

  def about
  end

  def contact
  end

  def education
  end

  def privacy_policy
  end

  private
  # https://stackoverflow.com/questions/19230379/rails-how-should-i-share-logic-between-controllers
  # find or create cart for guest users 
  def get_cart
    user = current_or_guest_user
    @cart = Cart.find_by(user_id: current_or_guest_user.id, active: true)
    if @cart.nil?
      @cart = Cart.create(user_id: current_or_guest_user.id, active: true)
    end
    @cart
  end
end

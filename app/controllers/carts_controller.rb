class CartsController < ApplicationController
  def create
    @cart = find_cart { create_cart }
  end

  def show
  end
end


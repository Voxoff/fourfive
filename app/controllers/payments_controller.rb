class PaymentsController < ApplicationController
  include CartControllable
  before_action :get_cart

  def checkout
    @disable_nav = true
    @cart_items = @cart.cart_items
    @amount = @cart_items.map{|i| i.product.price }.reduce(:+)
    if @cart_items.empty?
      flash[:notice] = "You need to put items in your cart in order to buy them!"
      redirect_to root_path
    end
    puts
    if !coupons.includes?(checkout_params[:coupon].upcase)
      flash[:notice] = "That coupon code did not work"
      redirect_to new_cart_payment_path
    else
      flash[:notice] = "Coupon successfully applied."
      @amount = @amount.to_f * 0.9
    end
    ['net/https', 'uri', 'json'].each(&method(:require))
    uri = URI('https://test.oppwa.com/v1/checkouts')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Net::HTTP::Post.new(uri.path)
    req.set_form_data({
      'authentication.userId' => '8a8294174b7ecb28014b9699220015cc',
      'authentication.password' => 'sy6KJsT8',
      'authentication.entityId' => '8a8294174b7ecb28014b9699220015ca',
      'amount' => "#{humanized_money @amount}",
      'currency' => 'EUR',
      'paymentType' => 'DB'
    })
    res = http.request(req)
    @result = JSON.parse(res.body)
    @checkoutId = @result["id"]
  end

  def new
    @cart_items = @cart.cart_items
    if @cart_items.empty?
      flash[:notice] = "You need to put items in your cart in order to buy them!"
      redirect_to root_path
    end
  end

  private

  def checkout_params
    params.permit(:first_line, :second_line, :postcode, :phone_number, :email, :coupon)
  end

  def coupons
    ["DOMDAY", "COUPON"]
  end
end

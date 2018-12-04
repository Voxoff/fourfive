class PaymentsController < ApplicationController
  include CartControllable
  before_action :get_cart

  def checkout
    @amount = @cart.amount
    if @cart_items.empty?
      flash[:notice] = "You need to put items in your cart in order to buy them!"
      redirect_to root_path
    end
    user = current_or_guest_user
    if user.cart != @cart
      flash[:notice] = "Error!"
      redirect_to root_path
    end
    @address = Address.new(address_params)
    @address.user = guest_user
    flash[:notice] = "Address was invalid" if !@address.save

    guest_user.email = checkout_params[:email] if checkout_params[:email]
    raise
    coupon = checkout_params[:coupon]
    if coupon && !coupons.includes?(coupon)
      flash[:notice] = "That coupon code did not work"
      redirect_to new_cart_payment_path
    else
      flash[:notice] = "Coupon successfully applied."
      @amount = @amount.to_f * 0.9
    end
    @checkoutId = zion
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
    params.require(:checkout).permit(:phone_number, :email, :coupon)
  end

  def address_params
    params.require(:checkout).permit(:first_line, :second_line, :postcode, :city)
  end

  def coupons
    ["DOMDAY", "COUPON"]
  end

  def zion
    ['net/https', 'uri', 'json'].each(&method(:require))
    uri = URI('https://test.oppwa.com/v1/checkouts')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Net::HTTP::Post.new(uri.path)
    req.set_form_data({
      'authentication.userId' => '8a8294174b7ecb28014b9699220015cc',
      'authentication.password' => 'sy6KJsT8',
      'authentication.entityId' => '8a8294174b7ecb28014b9699220015ca',
      'amount' => "79",
      'currency' => 'EUR',
      'paymentType' => 'DB'
    })
    res = http.request(req)
    @result = JSON.parse(res.body)
    @checkoutId = @result["id"]
  end
end

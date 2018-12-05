class PaymentsController < ApplicationController
  include CartControllable
  before_action :get_cart

  def checkout
    @amount = @cart.amount
    @cart_items = @cart.cart_items
    user = current_or_guest_user
    coupon = checkout_params[:coupon]
    if @cart_items.empty?
      flash[:notice] = "You need to put items in your cart in order to buy them!"
      return redirect_to root_path
    elsif user.cart != @cart
      flash[:notice] = "Error!"
      return redirect_to root_path
    end
    if coupon.present? && coupons.include?(coupon)
      flash[:notice] = "Coupon successfully applied."
      @amount = @amount.to_f * 0.9
    elsif coupon.present? && !coupons.include?(coupon)
      flash[:notice] = "That coupon code did not work"
      return redirect_to new_cart_payment_path
    end
    @address = Address.new(address_params)
    @address.user = user #check if the user already has an identical address with validations
    flash[:notice] = "Address was invalid" unless @address.save
    if user.guest? && checkout_params[:email]
      guest_user.email = checkout_params[:email]
    end
    # Now we need to store the cart, change it to false and create a new cart
    @checkoutId = zion
  end

  def new
    @cart_items = @cart.cart_items
    if @cart_items.empty?
      flash[:notice] = "You need to put items in your cart in order to buy them!"
      return redirect_to root_path
    end
  end

  def success
    #params => id=0033E3B0DA7F4867166FCB43FBB0FF0F.uat01-vm-tx04&
              #resourcePath=%2Fv1%2Fcheckouts%2F0033E3B0DA7F4867166FCB43FBB0FF0F.uat01-vm-tx04%2Fpayment
    require 'net/https'
    require 'uri'
    require 'json'
  	path = ("?authentication.userId=8a8294174b7ecb28014b9699220015cc" +
		"&authentication.password=sy6KJsT8" +
		"&authentication.entityId=8a8294174b7ecb28014b9699220015ca")
	  uri = URI.parse('https://test.oppwa.com/v1/checkouts/{id}/payment' + path)
	  http = Net::HTTP.new(uri.host, uri.port)
	  http.use_ssl = true
	  res = http.get(uri.request_uri)
    return JSON.parse(res.body)
    #     {
    #   "result":{
    #     "code":"200.300.404",
    #     "description":"invalid or missing parameter - (opp) No payment session found for the requested id - are you mixing test/live servers or have you paid more than 30min ago?"
    #   },
    #   "buildNumber":"7469d0e5bd2dccca50bbd107625279e76a2c9ff3@2018-12-04 10:59:49 +0000",
    #   "timestamp":"2018-12-05 16:13:13+0000",
    #   "ndc":"8a8294174b7ecb28014b9699220015ca_844fa63b992e44a393277185e4aa7b2b"
    # }
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

  def success_params
    params.permit(:id, :resourcePath)
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

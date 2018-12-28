class PaymentsController < ApplicationController
  include CartControllable
  include PunditControllable

  before_action :find_cart
  before_action :pundit_placeholder, only: %i[checkout new]

  def checkout
    @amount = @cart.amount
    @cart_items = @cart.cart_items
    user = current_or_guest_user
    verify_coupon(checkout_params[:coupon])
    check_empty_cart
    @address = @cart.build_address(address_params)
    flash[:notice] = "Address was invalid" unless @address.save
    guest_user.email = checkout_params[:email] if user.guest? && checkout_params[:email]
    @checkout_id = zion
  end

  def new
  end

  def success
    payments = zion_info
    code = payments["result"]["code"]
    code_check(code)
    if code =~ /^(000\.000\.|000\.100\.1|000\.[36])/ || code =~ /^(000\.400\.0[^3]|000\.400\.100)/
      email_hash = { amount: @cart.amount, address: @cart.address, cart_items: @cart.cart_items, date: @cart.checkout_time }
      PaymentMailer.order(email_hash).deliver_now
      @cart = @cart.checkout
    end
    redirect_to root_path
  end

  private

  def checkout_params
    params.require(:checkout).permit(:phone_number, :email, :coupon)
  end

  def address_params
    params.require(:checkout).permit(:first_line, :second_line, :third_line, :postcode, :city, :first_name, :last_name)
  end

  def check_empty_cart
    return unless @cart_items.empty?

    flash[:notice] = "You need to put items in your cart in order to buy them!"
    return redirect_to root_path
  end

  def coupons
    [ENV['COUPON'].to_s]
  end

  def verify_coupon(coupon)
    if coupon.present?
      if coupons.include?(coupon)
        flash[:notice] = "Coupon successfully applied."
        @amount = @amount.to_f * 0.9
      elsif !coupons.include?(coupon)
        flash[:notice] = "That coupon code did not work"
        return redirect_to new_cart_payment_path
      end
    end
  end

  def zion
    ['net/https', 'uri', 'json'].each(&method(:require))
    uri = URI('https://oppwa.com/v1/checkouts')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Net::HTTP::Post.new(uri.path)

    req.set_form_data(
      'authentication.userId' => ENV['ZION_USER_ID'].to_s,
      'authentication.password' => ENV['ZION_PWD'].to_s,
      'authentication.entityId' => ENV['ZION_ENTITY_ID'].to_s,
      'amount' => @amount.to_f.to_s,
      'currency' => 'GBP',
      'paymentType' => 'DB'
      # 'billing.street1' => @cart.address.first_line.to_s,
      # 'billing.street2' => @cart.address.second_line.to_s,
      # 'billing.city' => @cart.address.city.to_s,
      # 'billing.postcode' => @cart.address.postcode.to_s,
      # 'billing.country' => "GB"
    )
    res = http.request(req)
    @result = JSON.parse(res.body)
    @checkout_id = @result["id"]
  end

  def zion_info
    ['net/https', 'uri', 'json'].each(&method(:require))
    path = ("?authentication.userId=#{ENV['ZION_USER_ID']}" +
    "&authentication.password=#{ENV['ZION_PWD']}" +
    "&authentication.entityId=#{ENV['ZION_ENTITY_ID']}")
    uri = URI.parse("https://oppwa.com/v1/checkouts/#{params[:id]}/payment" + path)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    res = http.get(uri.request_uri)
    puts JSON.parse(res.body)
    return JSON.parse(res.body)
  end

  def code_check(code)
    if code.match?(/^(000\.000\.|000\.100\.1|000\.[36])/) || code.match?(/^(000\.400\.0[^3]|000\.400\.100)/)
      flash[:notice] = "Thank you. Your payment has been processed."
    elsif code.match?(/^(000\.200)/)
      flash[:notice] = "Pending. Please wait for email confirmation."
    elsif code.match?(/^(800\.400\.5|100\.400\.500)/)
      flash[:notice] = "Waiting for confirmation/external risk. Denied for now."
    else
      flash[:notice] = "Payment rejected. It looks like you filled in your details incorrectly."
    end
  end

end

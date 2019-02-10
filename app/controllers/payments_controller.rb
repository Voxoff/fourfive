class PaymentsController < ApplicationController
  include CartControllable
  include PunditControllable

  before_action :find_cart
  before_action :pundit_placeholder, only: %i[checkout new]

  def checkout
    @amount = @cart.amount
    @cart_items = @cart.cart_items
    user = current_or_guest_user
    check_empty_cart
    @ip = request.remote_ip
    gdpr
    @address = @cart.build_address(address_params)
    unless @address.save
      flash[:notice] = "Address was invalid"
      redirect_to new_cart_payment_path(@cart)
    end
    guest_user.email = params[:email] if user.guest? && params[:email]
    @checkout_id = zion
  end

  def new
    @countries = Address.countries.map {|k,v| [v,k]}
  end

  def success
    payments = zion_info
    code = payments["result"]["code"]
    code_check(code)
    if code =~ /^(000\.000\.|000\.100\.1|000\.[36])/ || code =~ /^(000\.400\.0[^3]|000\.400\.100)/
      # PaymentMailer.success(@cart.address.email, @cart.id).deliver_later
      invoice
      @cart = @cart.checkout
    elsif code.match?(/^(000\.200)/)
      # PaymentMailer.alert_mike(@cart.id).deliver_later
      # @cart = @cart.checkout
    end
    redirect_to root_path
  end

  def invoice
    xero = Xeroizer::PrivateApplication.new(ENV["OAUTH_CONSUMER_KEY"], ENV["OAUTH_CONSUMER_SECRET"], Rails.root.join('privatekey.pem'))

    invoice = InvoiceService.new(@cart, xero).produce

    # contact = xero.Contact.build(
    #   :name => "x",
    #   :first_name => @cart.address.first_name,
    #   :last_name => @cart.address.last_name)
    # contact.add_address(
    #   :type => "DEFAULT",
    #   :line1 => @cart.address.first_line,
    #   :line2 => @cart.address.second_line,
    #   :line3 => @cart.address.third_line,
    #   :city => @cart.address.city,
    #   # :postcode => @cart.address.postcode,
    #   # :country => @cart.address.country
    # )
    # contact.add_phone(:number => @cart.address.phone_number)
    # # contact.title = @cart.address.salutation
    # # contact.add_email

    # invoice = xero.Invoice.build(:type => "ACCREC", :contact => contact, :date => DateTime.now, :due_date => DateTime.new(2017,11,19))
    # @cart.cart_items.each do |cart_item|
    #   invoice.add_line_item(:description => cart_item.description, :unit_amount => cart_item.unit_amount, :quantity => cart_item.quantity, :account_code => '200')
    # end
    # invoice.save!
  end

  private

  def address_params
    params.require(:checkout).permit(:first_line, :second_line, :third_line, :salutation, :country, :email,
                                     :phone_number, :postcode, :city, :first_name, :last_name
                                    )
  end

  def gdpr
    if params[:checkout][:terms] == "0"
      flash[:notice] = "You must accept the terms and conditions."
      return redirect_to new_cart_payment_path(@cart)
    end
    @cart.agree
  end

  def check_empty_cart
    return unless @cart_items.empty?

    flash[:notice] = "You need to put items in your cart in order to buy them!"
    return redirect_to root_path
  end

  def zion
    ['net/https', 'uri', 'json'].each(&method(:require))
    if Rails.env.development? || ENV['STAGING'].present?
      uri = URI('https://test.oppwa.com/v1/checkouts')
    else
      uri = URI('https://oppwa.com/v1/checkouts')
    end
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Net::HTTP::Post.new(uri.path)
    req.set_form_data(
      'authentication.userId' => ENV['ZION_USER_ID'].to_s,
      'authentication.password' => ENV['ZION_PWD'].to_s,
      'authentication.entityId' => ENV['ZION_ENTITY_ID'].to_s,
      'amount' => @amount.to_f.to_s,
      'currency' => 'GBP',
      'paymentType' => 'DB',
      'customer.givenName'=> @address.first_name.to_s,
      'customer.surname'=> @address.last_name.to_s,
      'customer.ip'=> @ip,
      'customer.phone'=> @address.phone_number.to_s,
      'customer.email'=> params["checkout"]["email"],
      'billing.street1' => @address.first_line.to_s,
      'billing.street2' => @address.second_line.to_s,
      'billing.city' => @address.city.to_s,
      'billing.postcode' => @address.postcode.to_s,
      'billing.country' => "GB"
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
    if Rails.env.development? || ENV['STAGING'].present?
      uri = URI.parse("https://test.oppwa.com/v1/checkouts/#{params[:id]}/payment" + path)
    else
      uri = URI.parse("https://oppwa.com/v1/checkouts/#{params[:id]}/payment" + path)
    end
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    res = http.get(uri.request_uri)
    puts JSON.parse(res.body)
    return JSON.parse(res.body)
  end

  def code_check(code)
    if code.match?(/^(000\.000\.|000\.100\.1|000\.[36])/) || code.match?(/^(000\.400\.0[^3]|000\.400\.100)/)
      flash[:notice] = "Thank you. Your payment has been processed."
      flash[:notice] = "Thank you. Your payment has been processed. An email will be sent shortly to #{@cart.address.email}" if @cart.address.email
    elsif code.match?(/^(000\.200)/)
      flash[:notice] = "The payment is pending. Please email contact@fourfive.co.uk in case it is rejected. Thank you."
    elsif code.match?(/^(800\.400\.5|100\.400\.500)/)
      flash[:notice] = "Waiting for confirmation/external risk. Denied for now. Please email contact@fourfive.co.uk for further details."
    else
      flash[:notice] = "Payment rejected. It looks like you filled in your details incorrectly."
    end
  end
end

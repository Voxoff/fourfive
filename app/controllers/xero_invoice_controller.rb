class XeroInvoiceController < ApplicationController
  def self.generate(cart)
    xero = XeroSessionController.new
    binding.pry
    xero.new
    xero.create
    invoice = create
    cart.cart_items.each do |cart_item|
      add_item(invoice, cart_item)
    end

    # authorise the invoice
    invoice.approve!

    invoice.save!
  end

  # new invoice
  def self.create
    xero = Xeroizer::PublicApplication.new(ENV["OAUTH_CONSUMER_KEY"], ENV["OAUTH_CONSUMER_SECRET"])
    xero.authorize_from_access(session[:xero_auth][:access_token], session[:xero_auth][:access_key])
    invoice = xero.Invoice.build(
      :type => "ACCREC",
      :contact => contact(xero),
      :date => DateTime.now
    )
  end
  # add item to invoice
  def self.add_item(invoice, cart_item)
    invoice.add_line_item(:description => cart_item.product.name,
      :unit_amount => cart_item.product.price_cents,
      :quantity => cart_item.quantity
    )
  end

  def contact(xero)
    xero.Contact.build(name: "Sam")
  end
end

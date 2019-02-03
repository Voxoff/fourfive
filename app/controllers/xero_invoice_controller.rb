class XeroInvoiceController < ApplicationController
  def self.generate(cart)
    invoice = create
    cart.cart_items.each do |cart_item|
      add_item(invoice, cart_item)
    end

    # authorise the invoice
    invoice.approve!

    invoice.save

    p invoice
    p xero.Invoice.find(invoice.id)
  end

  # new invoice
  def self.create
    xero = Xeroizer::PublicApplication.new(ENV["OAUTH_CONSUMER_KEY"], ENV["OAUTH_CONSUMER_SECRET"])
    xero.authorize_from_access(session[:xero_auth][:access_token], session[:xero_auth][:access_key])
    invoice = xero.Invoice.build(
      :type => "ACCREC",
      # :contact => contact,
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
end

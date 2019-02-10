class InvoiceService
  def initialize(cart, xero)
    @cart = cart
    @xero = xero
  end

  def produce
    invoice = @xero.Invoice.build(:type => "ACCREC", :contact => build_contact, :date => DateTime.now, :due_date => DateTime.new(2017,11,19))
    @cart.cart_items.each do |cart_item|
      invoice.add_line_item(:description => cart_item.description, :unit_amount => cart_item.unit_amount, :quantity => cart_item.quantity, :account_code => '200')
    end
    invoice.save!
  end

  private

  def build_contact
    contact = @xero.Contact.build(
      :name => "x",
      :first_name => @cart.address.first_name,
      :last_name => @cart.address.last_name
    )
    contact.add_address(
      :type => "DEFAULT",
      :line1 => @cart.address.first_line,
      :line2 => @cart.address.second_line,
      :line3 => @cart.address.third_line,
      :city => @cart.address.city,
      # :postcode => @cart.address.postcode,
      # :country => @cart.address.country
    )
    return contact
  end
end

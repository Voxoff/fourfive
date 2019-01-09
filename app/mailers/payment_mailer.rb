class PaymentMailer < ApplicationMailer

  def success(email, cart_id)
    @cart = Cart.find(cart_id)
    email_hash = { order_id: @cart.order_id, amount: @cart.amount, address: @cart.address, cart_items: @cart.cart_items, date: @cart.checkout_time }
    add_pdf(email_hash)
    if Rails.env.development?
      mail(to: "guy@fourfivecbd.co.uk", subject: "Receipt") if email
    else
      mail(to: email, subject: "Receipt") if email
    end
  end

  def order(pdf)
    add_pdf(pdf)
    if Rails.env.development?
      mail(to: "guy@fourfivecbd.co.uk", subject: "Order")
    else
      mail(to: "orders@fourfivecbd.co.uk", subject: "Order", cc: "mike@fourfivecbd.co.uk")
    end
  end

  private

  def add_pdf(email_hash)
    attachments["receipt.pdf"] = InvoicePdf.new(email_hash).render
  end
end

class PaymentMailer < ApplicationMailer

  def success(email, cart_id)
    @cart = Cart.find(cart_id)
    email_hash = { order_id: @cart.order_id, amount: @cart.amount, address: @cart.address, cart_items: @cart.cart_items, date: @cart.checkout_time }
    add_pdf(email_hash)
    if Rails.env.development? || ENV['staging'].present?
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
    # resp = Cloudinary::Uploader.upload(pdf, public_id: "receipts/receipt#{@cart.order_id}")
    # resp["secure_url"]
    # mem = GetProcessMem.new
    # puts mem.inspect
    Prawn::Font::AFM.hide_m17n_warning = true
    pdf = InvoicePdf.new(email_hash).render

    s = StringIO.new(pdf)
    # https://stackoverflow.com/questions/31487710/how-to-handle-a-file-as-string-generated-by-prawn-so-that-it-is-accepted-by-ca/31517824#31517824
    def s.original_filename; "receipt"; end
    @cart.receipt = s
    @cart.save!
    attachments["receipt.pdf"] = pdf
    pdf = nil
    s = nil
    GC.start
    # puts mem.inspect
  end
end

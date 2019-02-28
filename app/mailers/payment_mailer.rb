class PaymentMailer < ApplicationMailer

  def success(email, cart_id)
    @cart = Cart.find(cart_id)
    add_pdf
    if Rails.env.development? || ENV['staging'].present?
      mail(to: "guy@fourfivecbd.co.uk", subject: "Receipt") if email
    else
      mail(to: email, subject: "Receipt") if email
    end
  end

  def alert_mike(cart_id)
    @cart = Cart.find(cart_id)
    if Rails.env.development?
      mail(to: "guy@fourfivecbd.co.uk", subject: "Order")
    else
      mail(to: "guy@fourfivecbd.co.uk", subject: "Order may not have gone through")
    end
  end

  private

  def add_pdf
    Prawn::Font::AFM.hide_m17n_warning = true
    pdf = InvoicePdf.new(@cart).render

    s = StringIO.new(pdf)
    # https://stackoverflow.com/questions/31487710/how-to-handle-a-file-as-string-generated-by-prawn-so-that-it-is-accepted-by-ca/31517824#31517824
    def s.original_filename; "receipt"; end
    @cart.receipt = s
    @cart.save!
    attachments["receipt.pdf"] = pdf
    pdf = nil
    s = nil
    GC.start
  end
end

class PaymentMailer < ApplicationMailer

  def success(email, email_hash)
    add_pdf(email_hash)
    mail(to: email, subject: "Receipt") if email
  end

  def order(email_hash)
    add_pdf(email_hash)
    @address = email_hash[:address]
    mail(to: "orders@fourfivecbd.co.uk", subject: "Order")
  end

  private

  def add_pdf(email_hash)
    Prawn::Font::AFM.hide_m17n_warning = true
    pdf = InvoicePdf.new(amount: email_hash[:amount],
                         address: email_hash[:address],
                         cart_items: email_hash[:cart_items],
                         date: email_hash[:date],
                         order_id: email_hash[:order_id]
                          )
    t = Tempfile.create do |f|
      pdf.render_file f
      f.flush
      File.read(f)
    end
    attachments["receipt.pdf"] = t if t
  end
end

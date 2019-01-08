class PaymentMailer < ApplicationMailer

  def success(email, email_hash)
    add_pdf(email_hash)
    # if Rails.env.development?
      mail(to: "guy@fourfivecbd.co.uk", subject: "Receipt") if email
    # else
      # mail(to: email, subject: "Receipt") if email
    # end

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
    # t = Tempfile.create do |f|
    #   pdf.render_file f
    #   f.flush
    #   File.read(f)
    # end
    attachments["receipt.pdf"] = InvoicePdf.new(email_hash).render
  end
end

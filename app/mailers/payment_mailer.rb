class PaymentMailer < ApplicationMailer

  def success(email, pdf)
    add_pdf(pdf)
    mail(to: email, subject: "Receipt") if email
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

  def add_pdf(pdf)
    t = Tempfile.create do |f|
      pdf.render_file f
      f.flush
      File.read(f)
    end
    attachments["receipt.pdf"] = t if t
  end
end

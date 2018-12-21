class PaymentMailer < ApplicationMailer

  def success(user)
    @user = user
    mail(to: @user.email, subject: "Receipt") if @user.email
  end

  def order(email_hash)
    add_pdf(email_hash)
    mail(to: "guy@fourfivecbd.co.uk", subject: "Order")
  end

  private

  def add_pdf(email_hash)
    pdf = InvoicePdf.new(amount:  email_hash[:amount],
                          address: email_hash[:address],
                          cart_items: email_hash[:cart_items],
                          date: email_hash[:date])
    t = Tempfile.create do |f|
      pdf.render_file f
      f.flush
      File.read(f)
    end
    attachments["receipt.pdf"] = t if t
  end
end

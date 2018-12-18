class PaymentMailer < ApplicationMailer

  def success(user)
    @user = user
    mail(to: @user.email, subject: "Receipt") if @user.email
  end

  private

  def add_pdf
    #https://stackoverflow.com/questions/21551435/rails-4-add-mail-attachment-as-remote-pdf-file
    file = generate
    attachments["receipt.pdf"] = file.read
  end
end

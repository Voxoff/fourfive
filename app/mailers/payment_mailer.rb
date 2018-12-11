class PaymentMailer < ApplicationMailer

  def success(user)
    @user = user
    mail(to: @user.email, subject: "Receipt") if @user.email
  end
end

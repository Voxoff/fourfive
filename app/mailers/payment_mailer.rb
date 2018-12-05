class PaymentMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.payment_mailer.Success.subject
  #
  def success(user)
    @user = user

    mail(to: @user.email, subject: "You have just bought a fourfive cbd product") if @user.email
  end
end

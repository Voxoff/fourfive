# config/initializers/development_email_interceptor.rb
if Rails.env.development?
  require "email_interceptor"
  ActionMailer::Base.register_interceptor(EmailInterceptor)
end

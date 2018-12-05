class ApplicationMailer < ActionMailer::Base
  default from: 'george@fourfivecbd.com' || 'dom@fourfivecbd.com'
  layout 'mailer'
end


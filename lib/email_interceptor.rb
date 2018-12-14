class EmailInterceptor
  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    message.to = [ 'tech@fourfivecbd.co.uk' ]
  end
end

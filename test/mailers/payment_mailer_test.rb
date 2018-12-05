require 'test_helper'

class PaymentMailerTest < ActionMailer::TestCase
  test "Success" do
    mail = PaymentMailer.Success
    assert_equal "Success", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end

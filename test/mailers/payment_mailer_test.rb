require 'test_helper'

class PaymentMailerTest < ActionMailer::TestCase
  test "success" do
    user = users(:one)
    mail = PaymentMailer.success(user)
    assert_equal "Receipt", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["contact@fourfivecbd.co.uk"], mail.from
    assert_match " bought", mail.body.encoded
  end
end


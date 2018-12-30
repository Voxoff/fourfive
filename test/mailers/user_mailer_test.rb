require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "welcome" do
    user = users(:one)
    mail = UserMailer.welcome(user)
    assert_equal "Welcome to fourfivecbd", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["contact@fourfivecbd.co.uk"], mail.from
    assert_match "Welcome to fourfive cbd", mail.body.encoded
  end

end

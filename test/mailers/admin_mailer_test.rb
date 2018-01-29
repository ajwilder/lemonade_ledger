require 'test_helper'

class AdminMailerTest < ActionMailer::TestCase
  test "new_day" do
    mail = AdminMailer.new_day
    assert_equal "New day", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "close_day" do
    mail = AdminMailer.close_day
    assert_equal "Close day", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end

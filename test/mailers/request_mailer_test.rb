require 'test_helper'

class RequestMailerTest < ActionMailer::TestCase
  test "client_request" do
    mail = RequestMailer.client_request
    assert_equal "Client request", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end

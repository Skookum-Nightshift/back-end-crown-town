class RequestMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.request_mailer.client_request.subject
  #
  def client_request body, email
    @body = body
    @email = email
    @title = "New Client Request"
    @icon_class = ""

    mail to: "to@example.org", from: @email, subject: "Client Request"
  end
end

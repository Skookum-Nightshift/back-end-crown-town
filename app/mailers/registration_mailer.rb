class RegistrationMailer < ApplicationMailer

  def welcome(user, password)
    @password = password
    @title = "Welcome to CrownTown Compost"
    @icon_class = ""

    mail to: user.email
  end

end

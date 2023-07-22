class EmailConfirmationMailer < ApplicationMailer
  default from: Passwordless.default_from_address

  def magic_link(email, session, token = nil)
    @session = session
    @token = token || session.token

    @magic_link = register_url(@token)
    mail(
      to: email,
      subject: "Welcome to #{Site.title}! Confirm your email address"
    )
  end
end

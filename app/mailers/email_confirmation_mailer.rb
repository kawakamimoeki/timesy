class EmailConfirmationMailer < ApplicationMailer
  default from: Passwordless.default_from_address

  def magic_link(email, session, token = nil)
    @session = session
    @token = token || session.token

    @magic_link = register_url(@token)
    mail(
      to: email,
      subject: I18n.t('passwordless.email_confirmation_mailer.magic_link.subject')
    )
  end
end

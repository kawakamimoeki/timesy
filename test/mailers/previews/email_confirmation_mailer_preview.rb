class EmailConfirmationMailerPreview < ActionMailer::Preview
  def magic_link
    email = "text@example.com"
    session = EmailConfirmationSession.new(email: email)
    token = Passwordless.token_generator.call(session)
    EmailConfirmationMailer.magic_link(email, session, token)
  end
end   

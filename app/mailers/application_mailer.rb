class ApplicationMailer < ActionMailer::Base
  default from: Site.sender_email
  layout "mailer"
end

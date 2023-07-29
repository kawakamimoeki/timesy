class ExportMailer < ApplicationMailer
  def failed(email:)
    mail(to: email, subject: I18n.t('exports.failed.title'))
  end

  def completed(email:, filepath:)
    @filepath = filepath
    mail(to: email, subject: I18n.t('exports.completed.title'))
  end
end

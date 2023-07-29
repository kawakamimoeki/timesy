class ExportJob < ApplicationJob
  queue_as :default

  def perform(user_id:)
    user = User.find(user_id)
    export = user.exports.create!
    export.upload_file!
    ExportMailer.completed(
      email: user.email,
      filepath: "#{Site.origin}/settings/exports/#{export.id}/download",
    ).deliver_later
  rescue StandardError => e
    export.update!(state: "failed")
    ExportMailer.failed(email: user.email).deliver_later
    raise e
  end
end

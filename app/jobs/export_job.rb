require "zip"

class ExportJob < ApplicationJob
  queue_as :default

  def perform(user_id:)
    user = User.find(user_id)
    export = user.exports.create!
    export.update!(state: "processing")
    file = Tempfile.new(["timesy-export-#{user.id}-", ".zip"])
    begin
      ::Zip::OutputStream.open(file.path) do |zip|
        user.posts.find_each do |post|
          zip.put_next_entry("post-#{post.id}.md")
          zip.write(post.to_markdown)
        end
        user.comments.find_each do |comment|
          zip.put_next_entry("comment-#{comment.id}.md")
          zip.write(comment.to_markdown)
        end
      end
      export.update!(state: "completed")
      export.file.attach(io: File.open(file.path), filename: "timesy-export-#{user.id}.zip")
      ExportMailer.completed(
        email: user.email,
        file_path: Rails.application.routes.url_helpers.rails_blob_url(export.file, host: Site.origin.match(/https?:\/\/(.*)/)[1])
      ).deliver_later
    ensure
      file.close
      file.unlink
    end
  rescue StandardError => e
    export.update!(state: "failed")
    ExportMailer.failed(email: user.email).deliver_later
    raise e
  end
end

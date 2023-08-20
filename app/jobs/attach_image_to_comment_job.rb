class AttachImageToCommentJob < ApplicationJob
  queue_as :default

  def perform
    Comment.all.each do |comment|
      comment.body.match(/!\[.*\]\((.*)\)/) do |m|
        url = m[1]
        res = Faraday.get(url).body
        file = StringIO.new(res)
        comment.images.attach(io: file, filename: m[1].split('/').last)
      end
    end
  end
end

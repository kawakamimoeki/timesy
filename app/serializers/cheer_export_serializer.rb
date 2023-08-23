class CheerExportSerializer < Blueprinter::Base
  identifier :body

  field :author do |comment, options|
    comment.user.username
  end

  field :created_at do |post, options|
    post.created_at.iso8601
  end

  field :updated_at do |post, options|
    post.updated_at.iso8601
  end
end

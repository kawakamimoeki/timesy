class PostExportSerializer < Blueprinter::Base
  identifier :body

  field :author do |post, options|
    post.user.username
  end

  field :created_at do |post, options|
    post.created_at.iso8601
  end

  field :updated_at do |post, options|
    post.updated_at.iso8601
  end

  association :threads, blueprint: CommentExportSerializer do |post, options|
    post.comments
  end

  association :comments, blueprint: CheerExportSerializer do |post, options|
    post.cheers
  end
end

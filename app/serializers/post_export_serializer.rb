class PostExportSerializer < Blueprinter::Base
  identifier :id

  field :body do |post, options|
    post.body.gsub(/!\[(.*)\]\((.*)\)/) do |match|
      relative_path = $2.gsub("http://res.cloudinary.com/dw1xpb7if/image/upload", "./images")
      "![#{$1}](#{relative_path})"
    end
  end

  field :author do |post, options|
    post.user.username
  end

  field :created_at do |post, options|
    post.created_at.iso8601
  end

  field :updated_at do |post, options|
    post.updated_at.iso8601
  end

  association :comments, blueprint: CommentExportSerializer do |post, options|
    post.comments
  end
end

class CheerExportSerializer < Blueprinter::Base
  identifier :id

  field :body do |comment, options|
    comment.body.gsub(/!\[(.*)\]\((.*)\)/) do |match|
      relative_path = $2.gsub("http://res.cloudinary.com/dw1xpb7if/image/upload", "./images")
      "![#{$1}](#{relative_path})"
    end
  end

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

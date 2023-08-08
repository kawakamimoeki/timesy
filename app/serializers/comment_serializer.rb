class CommentSerializer < Blueprinter::Base
  identifier :id

  fields :body, :created_at, :updated_at

  field :user do |comment, options|
    UserSerializer.render_as_hash(comment.user)
  end

  field :post do |comment, options|
    PostSerializer.render_as_hash(comment.post).except(:comments)
  end

  field :html do |comment, options|
    comment.html
  end
end

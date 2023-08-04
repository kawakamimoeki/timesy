module Webhooks
  class CommentSerializer < Blueprinter::Base
    identifier :id

    fields :body, :created_at, :updated_at

    field :user do |comment|
      Webhooks::UserSerializer.render_as_hash(comment.user)
    end

    field :post do |comment|
      Webhooks::PostSerializer.render_as_hash(comment.post).except(:comments, :user)
    end
  end
end

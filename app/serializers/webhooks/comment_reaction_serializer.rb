module Webhooks
  class CommentReactionSerializer < Blueprinter::Base
    identifier :id

    fields :body, :created_at, :updated_at

    field :user do |comment_reaction|
      Webhooks::UserSerializer.render_as_hash(comment_reaction.user)
    end

    field :comment do |comment_reaction|
      Webhooks::CommentSerializer.render_as_hash(comment_reaction.comment).except(:user, :post)
    end
  end
end

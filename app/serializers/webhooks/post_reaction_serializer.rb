module Webhooks
  class PostReactionSerializer < Blueprinter::Base
    identifier :id

    fields :body, :created_at, :updated_at

    field :user do |post_reaction|
      Webhooks::UserSerializer.render_as_hash(post_reaction.user)
    end

    field :post do |post_reaction|
      Webhooks::PostSerializer.render_as_hash(post_reaction.post).except(:comments, :user)
    end
  end
end

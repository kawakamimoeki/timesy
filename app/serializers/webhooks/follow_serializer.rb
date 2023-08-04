module Webhooks
  class FollowSerializer < Blueprinter::Base
    identifier :id

    fields :created_at, :updated_at

    field :follower do |follow|
      Webhooks::UserSerializer.render_as_hash(follow.follower)
    end

    field :followee do |follow|
      Webhooks::UserSerializer.render_as_hash(follow.followee)
    end
  end
end

module Webhooks
  class PostSerializer < Blueprinter::Base
    identifier :id

    fields :body, :created_at, :updated_at

    field :user do |post|
      Webhooks::UserSerializer.render_as_hash(post.user)
    end
  end
end

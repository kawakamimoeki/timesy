module Webhooks
  class UserSerializer < Blueprinter::Base
    identifier :id

    fields :username, :name

    field :avatar do |user|
      user.avatar_icon
    end
  end
end

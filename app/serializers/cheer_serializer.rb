class CheerSerializer < Blueprinter::Base
  identifier :id

  fields :body, :created_at, :updated_at

  field :user do |comment, options|
    UserSerializer.render_as_hash(comment.user)
  end

  field :html do |comment, options|
    comment.html
  end
end

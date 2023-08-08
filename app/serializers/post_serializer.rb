class PostSerializer < Blueprinter::Base
  identifier :id

  fields :body, :created_at, :updated_at

  field :user do |post, options|
    UserSerializer.render_as_hash(post.user)
  end

  field :projects do |post, options|
    ProjectSerializer.render_as_hash(post.projects)
  end

  field :html do |post, options|
    post.html
  end
end

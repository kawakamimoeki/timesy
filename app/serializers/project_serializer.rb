class ProjectSerializer < Blueprinter::Base
  identifier :id

  fields :title, :body, :codename, :link, :created_at, :updated_at
  
  field :user do |project, options|
    UserSerializer.render_as_hash(project.user)
  end
end

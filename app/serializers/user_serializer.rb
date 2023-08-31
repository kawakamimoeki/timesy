class UserSerializer < Blueprinter::Base
  identifier :id

  fields :name, :username, :email, :avatar_icon, :created_at, :updated_at
end

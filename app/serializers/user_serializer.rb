class UserSerializer < Blueprinter::Base
  identifier :id

  fields :username, :email, :created_at, :updated_at
end

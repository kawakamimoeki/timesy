class CreateProjectJob < ApplicationJob
  queue_as :default

  def perform(post)
    post.body.gsub!(/#([a-z0-9_]*)/) do |match|
      if Project.exists?(codename: $1)
        return
      else
        project = Project.create(
          codename: $1,
          title: $1,
          body: $1,
          user: post.user
        )
        post.attach_projects!
      end
    end
  end
end

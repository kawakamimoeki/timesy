class MarkdownProcessor
  class ProjectTag
    def self.process(markdown)
      markdown.gsub(/#(\w+)/) do |match|
        project = Project.find_by(codename: $1)
        if project
          %(<a href="/#{project.user.username}/projects/#{project.codename}" data-controller="tooltip" data-tooltip-text-value="#{project.title} @#{project.user.username}" data-turbo="false" class="project-tag">#{$&}</a>)
        else
          match
        end
      end
    end
  end
end

class MarkdownProcessor
  class ProjectTag
    def self.process(html)
      doc = Nokogiri::HTML::DocumentFragment.parse(html)
      doc.css('p').each do |paragraph|
        paragraph.children.each do |child|
          next unless child.text?
          child.replace(child.content.gsub(/#(\w+)/) do |match|
            project = Project.find_by(codename: $1)
            if project
              %(<a href="/#{project.user.username}/projects/#{project.codename}" data-controller="tooltip" data-tooltip-text-value="#{project.title} @#{project.user.username}" data-turbo="false" class="project-tag">#{$&}</a>)
            else
              match
            end
          end)
        end
      end
      doc.to_s
    end
  end
end

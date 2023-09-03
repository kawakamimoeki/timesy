require_relative "config/application"

Rails.application.load_tasks

desc "code theme seed"
task code_theme_seed: :environment do
  data = YAML.load_file(Rails.root.join('db', 'seeds', 'code_themes.yaml'))
  CodeTheme.create(data)
end

desc "Index search"
task index_search: :environment do
  Post.reindex!
end

desc "Attach image to comment"
task attach_image_to_comment: :environment do
  Comment.all.each do |comment|
    comment.images.purge
    comment.body.match(/!\[.*\]\((http:\/\/res.cloudinary.com.*)\)/) do |m|
      url = m[1]
      res = Faraday.get(url).body
      file = StringIO.new(res)
      comment.images.attach(io: file, filename: m[1].split('/').last)
    end
  end
end

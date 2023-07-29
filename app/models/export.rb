require "google/cloud/storage"
require "zip"

class Export < ApplicationRecord
  has_one_attached :file
  belongs_to :user

  def storage
    Google::Cloud::Storage.new
  end

  def bucket
    storage.bucket("timesy-exports")
  end

  def upload_file!
    update!(state: "processing")
    tempfile = Tempfile.new(filename)
    ::Zip::OutputStream.open(tempfile.path) do |zip|
      user.posts.find_each do |post|
        zip.put_next_entry("post-#{post.id}.json")
        zip.write(
          JSON.pretty_generate(PostExportSerializer.render_as_hash(post))
        )
      end
    end
    update!(state: "completed")
    if ENV["STORAGE_PROJECT"].present?
      bucket.create_file(tempfile.path, filename)
    else
      file.attach(io: tempfile, filename: filename)
    end
  end

  def download
    if ENV["STORAGE_PROJECT"].present?
      bucket.file(filename).download.read
    else
      file
    end
  end

  private def filename
    "timesy-export-#{id}.zip"
  end
end

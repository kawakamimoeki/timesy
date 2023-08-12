class MeilisearchIndexJob < ApplicationJob
  def perform(klass, id, remove)
    if remove
      klass.index.delete_document(id)
    else
      # The record should be present.
      klass.find(id).index!
    end
  end
end

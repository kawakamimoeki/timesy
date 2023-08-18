MeiliSearch::Rails.configuration = {
  meilisearch_url: ENV['MEILISEARCH_URL'],
  meilisearch_api_key: ENV['MEILISEARCH_MASTER_KEY'],
  pagination_backend: :kaminari
}

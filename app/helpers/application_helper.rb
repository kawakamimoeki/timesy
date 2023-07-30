module ApplicationHelper
  def default_meta_tags
    {
      site: Site.title,
      title: Site.description,
      reverse: false,
      charset: 'utf-8',
      description: Site.description,
      canonical: request.original_url,
      separator: '｜',
      icon: [
        { href: "#{Site.origin}/favicon.ico" },
      ],
      og: {
        site_name: :site,
        title: :site,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: "#{Site.origin}/ogp.png",
        local: 'ja-JP',
      },
      twitter: {
        card: 'summary_large_image',
        image: "#{Site.origin}/ogp.png",
      }
    }
  end

  def primary_button_class
    "rounded-sm px-2 py-1 shadow-sm text-white bg-sky-500 font-bold hover:bg-sky-600 transition-all disabled:opacity-30 cursor-pointer text-sm"
  end

  def label_class
    "block text-gray-700 text-sm font-bold mb-2"
  end

  def text_field_class
    "block rounded w-full px-3 py-2 border text-gray-700 bg-white hover:bg-gray-100 transition-all"
  end

  def loading_box_class
    "h-48 shadow-sm w-full bg-gray-100 duration-75 border-b animate-pulse transition"
  end

  def should_render_sidebar?
    !request.path.match?(/\/users\/\w+/)
  end
end

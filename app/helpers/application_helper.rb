module ApplicationHelper
  def default_meta_tags
    {
      site: Site.title,
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
    "rounded-sm px-2 py-1 shadow text-white bg-sky-500 font-bold hover:bg-sky-600 transition-all disabled:opacity-30 cursor-pointer flex items-center space-x-1"
  end

  def label_class
    "block text-gray-700 font-bold mb-2 dark:text-gray-200"
  end

  def text_field_class
    "block rounded w-full max-w-3xl px-3 py-2 border text-gray-700 transition-all dark:bg-dark-card dark:border dark:border-dark-border dark:text-gray-200"
  end

  def loading_box_class
    "h-48 shadow-sm w-full bg-gray-100 duration-75 border-b animate-pulse transition"
  end

  def nav_class
    "w-full flex items-center shadow font-bold dark:border-dark-border sticky space-x-3 z-[50] bg-background dark:bg-dark-background dark:text-gray-200 text-gray-700 bg-opacity-70 dark:bg-opacity-70 backdrop-filter backdrop-blur-lg dark:backdrop-blur-lg dark:backdrop-filter relative mt-4 rounded-lg mb-4 top-[1rem] max-w-4xl mx-auto"
  end

  def nav_list_class
    "flex max-w-4xl px-4 mx-auto w-full items-center"
  end

  def nav_item_class(path)
    "hover:opacity-100 py-2 text-center dark:border-dark-border border-b #{path.in?([request.path, params[:current]]) ? " border-sky-600 dark:border-sky-600" : "opacity-30"}"
  end

  def card_class
    "relative bg-white p-4 rounded-lg shadow mb-4 dark:text-gray-200 dark:bg-dark-card dark:border dark:border-dark-border dark:text-gray-200"
  end

  def block_link_class
    "py-1 px-2 block hover:bg-gray-50 rounded-lg dark:hover:bg-gray-700 transition-all dark:text-gray-200 flex items-center space-x-1 font-bold text-gray-700 hover:shadow transition-all"
  end

  def icon_button_class
    "block rounded-full hover:shadow transition-all cursor-pointer p-relative p-2 hover:bg-gray-50 transition-all dark:hover:bg-gray-700"
  end

  def dropdown_class
    "overflow-scroll absolute top-10 right-0 z-[100] hidden w-72 bg-white dark:bg-dark-card shadow rounded-lg border dark:border-dark-border scrollbar-none transition-all animate-down"
  end

  def backdrop_class
    "hidden fixed top-0 bottom-0 right-0 left-0 inset-0 z-[90] bg-black opacity-0"
  end

  def should_render_sidebar?
    !request.path.match?(/users/)
  end
end

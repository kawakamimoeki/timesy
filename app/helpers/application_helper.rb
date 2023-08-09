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
    "rounded-sm px-2 py-1 shadow-sm text-white bg-sky-500 font-bold hover:bg-sky-600 transition-all disabled:opacity-30 cursor-pointer"
  end

  def label_class
    "block text-gray-700 font-bold mb-2 dark:text-[#ddd]"
  end

  def text_field_class
    "block rounded w-full max-w-2xl px-3 py-2 border text-gray-700 transition-all dark:bg-[rgb(30,39,50)] dark:border dark:border-[#30363d] dark:text-[#ddd]"
  end

  def loading_box_class
    "h-48 shadow-sm w-full bg-gray-100 duration-75 border-b animate-pulse transition"
  end

  def nav_class
    "w-full flex items-center border-b dark:border-[#30363d] sticky space-x-3 mb-4 top-0 z-[50] bg-[rgb(246,248,250)] dark:bg-[rgb(21,32,43)]"
  end

  def nav_list_class
    "flex max-w-3xl px-4 mx-auto w-full items-center space-x-5"
  end

  def nav_item_class(path)
    "hover:opacity-100 py-2 text-center dark:border-[#30363d] border-b #{request.path == path ? "font-bold border-sky-600 dark:border-sky-600" : "opacity-50"}"
  end

  def card_class
    "relative bg-white p-4 rounded-lg border mb-4 dark:text-[#ddd] dark:bg-[rgb(30,39,50)] dark:border-[#30363d] dark:text-[#ddd]"
  end

  def block_link_class
    "py-1 px-2 block hover:bg-gray-50 rounded dark:hover:bg-gray-700 transition-all dark:text-[#ddd]"
  end

  def icon_button_class
    "block rounded-full cursor-pointer p-relative p-2 hover:bg-gray-50 transition-all dark:hover:bg-gray-700"
  end

  def dropdown_class
    "overflow-scroll absolute top-8 right-0 z-[100] hidden w-72 bg-white dark:bg-[rgb(30,39,50)] shadow rounded-lg border dark:border-[rgb(48,54,61)]"
  end

  def backdrop_class
    "hidden fixed top-0 bottom-0 right-0 left-0 inset-0 z-[90] bg-black opacity-0"
  end

  def should_render_sidebar?
    !request.path.match?(/users/)
  end
end

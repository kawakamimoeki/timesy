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
        image: "#{Site.origin}/landing.png",
        local: 'ja-JP',
      },
      twitter: {
        card: 'summary_large_image',
        image: "#{Site.origin}/ogp.png",
      }
    }
  end

  def primary_button_class
    "px-3 py-2 shadow-sm text-white text-sm bg-sky-500 font-bold hover:bg-sky-600 transition-all disabled:opacity-30  rounded"
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
    "w-full flex items-center border-b font-bold dark:border-b dark:border-dark-border sticky space-x-3 z-[50] bg-white dark:bg-dark-background dark:text-gray-200 text-gray-700 relative h-[40px]"
  end

  def nav_list_class
    "flex max-w-3xl px-4 py-2 mx-auto w-full items-center"
  end

  def nav_item_class(path)
    "hover:opacity-100 py-2 text-center opacity-30"
  end

  def card_class
    "relative bg-white p-4 dark:text-gray-200 dark:bg-dark-card dark:border-dark-border dark:text-gray-200"
  end

  def block_link_class
    "py-1 px-2 flex items-center text-sm gap-1 hover:bg-gray-50 rounded dark:hover:bg-gray-700 transition-all dark:text-gray-200  text-gray-800 hover:shadow-sm transition-all"
  end

  def icon_button_class
    "block rounded hover:shadow-sm transition-all text-lg text-gray-700 dark:text-gray-300 shadow-sm  p-relative p-2 transition-all dark:hover:bg-gray-700 border dark:border-dark-border hover:bg-gray-100 hover:dark:bg-gray-700"
  end

  def dropdown_class
    "overflow-scroll absolute top-10 right-0 z-[100] hidden w-72 bg-white dark:bg-dark-card shadow-sm rounded border dark:border-dark-border scrollbar-none transition-all animate-down"
  end

  def backdrop_class
    "hidden fixed top-0 w-screen h-screen left-0 inset-0 z-[90] bg-black opacity-0"
  end

  def indicator_class
    "w-auto h-[32px] leading-[32px] mr-1 px-3 my-1 flex items-center border bg-gray-50 dark:bg-slate-700 dark:border-slate-700 border-gray-50 text-sm rounded-full"
  end

  def should_render_sidebar?
    !request.path.match?(/users/)
  end
end

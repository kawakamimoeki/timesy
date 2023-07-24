class WebfingerController < ApplicationController
  def index
    username = username(params[:resource])
    unless username
      return render file: 'public/404.html', status: 404
    end

    res = {
      subject: "acct:#{username}@timesy.dev",
      aliases: [
        "mailto:#{username}@timesy.dev",
        "https://timesy.dev/@#{username}",
        "https://timesy.dev/u/#{username}",
        "https://timesy.dev/user/#{username}",
        "https://timesy.dev/users/#{username}"
      ],
      links: [
        {
          rel: 'self',
          type: 'application/activity+json',
          href: "https://timesy.dev/u/#{username}"
        },
        {
          rel: 'http://webfinger.net/rel/avatar',
          type: 'image/png',
          href: "https://timesy.dev/public/#{username}u.png"
        },
        {
          rel: 'http://webfinger.net/rel/profile-page',
          type: 'text/plain',
          href: "https://timesy.dev/u/#{username}"
        }
      ]
    }
    render json: res, content_type: 'application/jrd+json'
  end

  private def username(resource)
    patterns = [
      /acct:(.*)@timesy.dev/,
      /mailto:(.*)@timesy.dev/,
      /https:\/\/timesy.dev\/@(.*)/,
      /https:\/\/timesy.dev\/u\/(.*)/,
      /https:\/\/timesy.dev\/user\/(.*)/,
      /https:\/\/timesy.dev\/users\/(.*)/
    ]
    patterns.each do |pattern|
      match = resource.match(pattern)
      if match
        username = match[1]
        if User.exists?(username: username)
          break username
        end
      end
    end
  end
end

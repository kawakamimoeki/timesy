module PostsHelper
  def ogp_image(post)
    "https://res.cloudinary.com/dw1xpb7if/image/upload/c_fit,g_west,h_190,l_text:jxfzypcvmrsidywwbv9l.ttf_48:#{post.user.name},w_448,x_270,y_-200/c_fit,h_128,l_fetch:#{Base64.encode64(post.user.avatar_icon).gsub(/\n/, "")},r_100,w_128,x_-420,y_-180/c_fit,g_west,l_text:jxfzypcvmrsidywwbv9l.ttf_32:@#{post.user.username},w_339,x_270,y_-145/c_fit,g_north_west,l_text:jxfzypcvmrsidywwbv9l.ttf_60:#{post.truncated(48).gsub(/#/, CGI.escape("#"))},w_1000,x_120,y_240/v1691627490/kia5wtjyvvkxvoiv8mmk.png"
  end
end

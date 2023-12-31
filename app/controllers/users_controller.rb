require "bcrypt"
require "rexml/document"

class UsersController < ApplicationController
  include Passwordless::ControllerHelpers

  def header
  end

  def code_theme
  end

  def wallpaper
  end

  def feed
    @user = User.find_by(username: params[:username])
    if @user.nil?
      render file: "#{Rails.root}/public/404.html", status: :not_found
      return
    end
    @posts = @user.posts.joins(:projects).merge(Project.rss).latest
    erb = ERB.new(File.read("#{Rails.root}/app/views/users/feed.xml.erb"))
    render xml: erb.result(binding).html_safe
  end

  def new
    if request.format == "text/html"
      set_cache_control_headers
    end
    @user = User.new
    render :new, layout: "layouts/landing"
  end

  def show
    @user = User.find_by(username: params[:username])
    @post_reaction = PostReaction.new

    if @user.nil?
      render file: "#{Rails.root}/public/404.html", status: :not_found
      return
    end

    page_limit = 20
    @current_page = params[:page].to_i

    all = Post.offset(page_limit*@current_page)
      .where(user_id: @user.id)
      .includes(:user, :comments, :post_reactions)
      .latest
    
    @posts = all.limit(params[:limit] || page_limit)
    @next_page = @current_page + 1 if all.count > page_limit*@current_page + page_limit
  end

  def confirm
    if User.find_by(email: user_params[:email])
      redirect_to "/users/sign_in", flash: { errors: [I18n.t("users.already_registered")] }
      return
    end

    confirm_session = EmailConfirmationSession.new(email: user_params[:email])
    if confirm_session.save
      EmailConfirmationMailer.magic_link(user_params[:email], confirm_session).deliver_now
      redirect_back(
        fallback_location: "/users/sign_up",
        flash: { notice: I18n.t("passwordless.check_your_email") }
      )
    else
      render :new
    end
  end

  def register
    return head(:ok) if request.head?
    BCrypt::Password.create(params[:token])
    confirm_session = EmailConfirmationSession.find_by(token: params[:token])
    @user = User.new(email: confirm_session.email)
    render :register, layout: "layouts/landing"
  rescue Passwordless::Errors::TokenAlreadyClaimedError
    redirect_to sign_up_path, flash: { errors: [I18n.t("passwordless.expired")] }
  rescue Passwordless::Errors::SessionTimedOutError
    redirect_to sign_up_path, flash: { errors: I18n.t("passwordless.expired") }
  end

  def create
    @user = User.new(user_params.merge(locale: I18n.locale))

    if @user.save
      sign_in @user
      redirect_to root_path
    else
      render :register
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])

    if @user != current_user
      render json: { error: "You are not authorized to delete this user." }, status: :unauthorized
      return
    end

    @user.destroy
    redirect_to "/"
  end

  def followers
    @current_page = params[:page].to_i
    @user = User.find_by(username: params[:username])
    all = @user.follower_users
    @followers = all.offset(20*@current_page).limit(20)
    @next_page = @current_page + 1 if all.count > 20*@current_page + 20
  end

  def following
    @current_page = params[:page].to_i
    @user = User.find_by(username: params[:username])
    all = @user.followee_users
    @followees = all.offset(20*@current_page).limit(20)
    @next_page = @current_page + 1 if all.count > 20*@current_page + 20
  end

  private def user_params
    params.require(:user).permit(:email, :username, :name)
  end
end

class ProjectsController < ApplicationController

  def list
    @user = User.find_by(username: params[:username])
    @projects = Project.where(user_id: @user.id)
  end

  def index
    @user = User.find_by(username: params[:username])
    @current_page = params[:page].to_i
    all_projects = Project.offset(page_limit*@current_page)
      .latest
      .where(user_id: @user.id)
    
    if params[:limit] || page_limit
      @projects = all_projects.limit(params[:limit] || page_limit)
    else
      @projects = all_projects
    end
    @next_page = @current_page + 1 if all_projects.count > page_limit*@current_page + page_limit
  end

  def show
    @user = User.find_by(username: params[:username])
    @project = Project.find_by(user_id: @user.id, codename: params[:codename])
    @current_page = params[:page].to_i

    @posts = @project.posts.offset(page_limit*@current_page)
      .order(updated_at: :desc)
      .limit(page_limit)
    @next_page = @current_page + 1 if Post.all.count > page_limit*@current_page + page_limit
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.user_id = current_user.id
    if @project.save
      redirect_to project_path(@project.user.username, @project.codename)
    else
      render :new
    end
  end

  def edit
    @user = User.find_by(username: params[:username])
    if @user.id != current_user.id
      redirect_to project_path(params[:username], params[:codename])
      return
    end
    @project = Project.find_by(user_id: @user.id, codename: params[:codename])
  end

  def update
    @user = User.find_by(username: params[:username])
    @project = Project.find_by(user_id: @user.id, codename: params[:id])
    
    if @user.id != current_user.id
      redirect_to projects_path(@user.username)
      return
    end

    if @project.nil?
      redirect_to projects_path(@user.username)
      return
    end

    if @project.update(project_params)
      @project.icon.attach(params[:project][:icon]) if params[:project][:icon]
      purge_page(@project)
      redirect_to project_path(@project.user.username, @project.codename)
    else
      render :edit
    end
  end

  def destroy
    if params[:username] != current_user.username
      redirect_to project_path(params[:username], params[:codename])
      return
    end

    @user = User.find_by(username: params[:username])
    @project = Project.find_by(user_id: @user.id, codename: params[:codename])
    @project.destroy
    redirect_to projects_path
  end

  private def purge_page(project)
    api_instance = Fastly::PurgeApi.new
    opts = {
        service_id: ENV['FASTLY_SERVICE_ID'],
        cached_url: "#{Site.origin}/#{project.user.username}/projects/#{project.codename}",
        fastly_soft_purge: 1
    }
    begin
      result = api_instance.purge_single_url(opts)
    rescue Fastly::ApiError => e
      Rails.logger.error("Exception when calling PurgeApi->purge_single_url: #{e}")
    end
  end

  private def project_params
    params.require(:project).permit(:title, :codename, :link, :body, :icon)
  end

  private def page_limit
    20
  end
end

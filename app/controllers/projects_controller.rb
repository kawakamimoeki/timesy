class ProjectsController < ApplicationController
  def index
    @user = User.find_by(username: params[:username])
    @projects = Project.where(user_id: @user.id)
  end

  def show
    @user = User.find_by(username: params[:username])
    @project = Project.find_by(user_id: @user.id, codename: params[:codename])
    page_limit = 20
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
    if @user.id != current_user.id
      redirect_to project_path(params[:username], params[:codename])
      return
    end

    @project = Project.find_by(user_id: @user.id, codename: params[:codename])
    if @project.update(project_params)
      @project.icon.attach(params[:project][:icon]) if params[:project][:icon]
      redirect_to project_path(@project.user.username, @project.codename)
    else
      render :edit
    end
  end

  def destroy
    if params[:username] != current_user.id.to_s
      redirect_to project_path(params[:username], params[:codename])
      return
    end

    @project = Project.find_by(user_id: params[:username], codename: params[:codename])
    @project.destroy
    redirect_to projects_path
  end

  private def project_params
    params.require(:project).permit(:title, :codename, :link, :body, :icon)
  end
end

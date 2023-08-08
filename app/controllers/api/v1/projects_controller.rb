module Api
  module V1
    class ProjectsController < ApplicationController
      before_action :authenticate_user!, only: [:create, :update, :destroy]
      skip_forgery_protection

      def preview
        @project = Project.new(body: project_params[:body])
        render json: { body: @project.html.html_safe }
      end

      def create
        @project = Project.new(project_params)
        @project.user = current_user
        @project.save
        render json: { project: ProjectSerializer.render_as_hash(@project) }
      end

      def update
        @project = Project.find(params[:id])
        if @project.user != current_user
          render json: { error: "You are not authorized to edit this project." }, status: 401
          return
        end
        @project.update(project_params)
        render json: { project: ProjectSerializer.render_as_hash(@project) }
      end

      def destroy
        @project = Project.find(params[:id])
        if @project.user != current_user
          render json: { error: "You are not authorized to delete this project." }, status: 401
          return
        end
        @project.destroy
        render json: {}, status: 204
      end

      private def project_params
        params.require(:project).permit(:title, :body, :link, :codename)
      end
    end
  end
end

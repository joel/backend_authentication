# frozen_string_literal: true

class ProjectsController < ApplicationController
  # before_action :set_project, only: %i[show update destroy]

  # # GET /projects
  # def index
  #   @projects = Project.all

  #   render json: @projects
  # end

  # # GET /projects/1
  # def show
  #   render json: @project
  # end

  # POST /projects
  def create
    Projects::Create.new.call(project_params.merge(user_id: Current.user.id)) do |operation|
      operation.success do |project|
        render json: project, status: :created, location: project
      end

      operation.failure do |error|
        render json: error.to_h, status: :unprocessable_entity
      end
    end
  end

  # # PATCH/PUT /projects/1
  # def update
  #   if @project.update(project_params)
  #     render json: @project
  #   else
  #     render json: @project.errors, status: :unprocessable_entity
  #   end
  # end

  # # DELETE /projects/1
  # def destroy
  #   @project.destroy
  # end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def project_params
    params.require(:project).permit(:name, :user_id)
  end
end

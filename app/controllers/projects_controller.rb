# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show update destroy]

  # GET /projects
  def index
    @projects = Project.all

    render json: @projects
  end

  # GET /projects/1
  def show
    render json: @project
  end

  # POST /projects
  def create
    operation_params = create_project_params.merge(user_id: Current.user.id)

    Projects::CreateOrUpdate.new.call(operation_params.to_h) do |operation|
      operation.success do |project|
        render json: project, status: :created, location: project
      end

      operation.failure do |error|
        render json: error.to_h, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /projects/1
  def update
    operation_params = create_project_params.merge(id: params[:id])

    Projects::CreateOrUpdate.new.call(operation_params.to_h) do |operation|
      operation.success do |project|
        render json: project, status: :ok, location: project
      end

      operation.failure do |error|
        render json: error.to_h, status: :unprocessable_entity
      end
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def create_project_params
    params.require(:project).permit(:name, :id)
  end

  # Only allow a list of trusted parameters through.
  def update_project_params
    params.require(:project).permit(:name)
  end
end

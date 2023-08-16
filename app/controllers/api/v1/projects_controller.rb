# frozen_string_literal: true

module Api
  module V1
    class ProjectsController < ApiController
      before_action :set_project, only: %i[show update]

      def index
        allowed = %i[id name]
        options = { sort_with_expressions: true }

        jsonapi_filter(Project.all, allowed, options) do |filtered|
          jsonapi_paginate(filtered.result) do |paginated|
            render jsonapi: paginated
          end
        end
      end

      def show
        render jsonapi: @project
      end

      def create
        project = Project.new(jsonapi_deserialize(params, only: %i[id name]))
        project.user_id = Current.user.id

        if project.save
          render jsonapi: project, status: :created, location: project
        else
          render jsonapi_errors: project.errors, status: :unprocessable_entity
        end
      end

      def update
        if @project.update(jsonapi_deserialize(params, only: [:name]))
          render jsonapi: @project, status: :ok, location: @project
        else
          render jsonapi_errors: @project.errors, status: :unprocessable_entity
        end
      end

      private

      def jsonapi_meta(resources)
        { total: resources.count } if resources.respond_to?(:count)
      end

      # The default implementation return ::ProjectSerializer
      def jsonapi_serializer_class(_resource, _is_collection)
        ::Api::V1::ProjectSerializer
      end

      def set_project
        @project = Project.find(params[:id])
      end
    end
  end
end

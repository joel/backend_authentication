# frozen_string_literal: true

module Api
  module V1
    class ProjectsController < ApiController
      def index
        allowed = %i[id name]
        options = { sort_with_expressions: true }

        jsonapi_filter(Project.all, allowed, options) do |filtered|
          jsonapi_paginate(filtered.result) do |paginated|
            render jsonapi: paginated
          end
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
    end
  end
end

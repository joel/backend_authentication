# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApiController
      # GET /users
      def index
        allowed = %i[id name]
        options = { sort_with_expressions: true }

        authorized_collection = User.all

        jsonapi_filter(authorized_collection, allowed, options) do |filtered|
          jsonapi_paginate(filtered.result) do |paginated|
            # render jsonapi: paginated # Trigger unexpected error: ArgumentError: wrong number of arguments (given 2, expected 0)

            render json: UserSerializer.new(paginated, is_collection: true).serializable_hash
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApiController
      # GET /users
      def index
        render json: User.all.map { |user| user.attributes.slice("id", "name") }
      end
    end
  end
end

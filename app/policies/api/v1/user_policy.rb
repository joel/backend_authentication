# frozen_string_literal: true

module Api
  module V1
    class UserPolicy < ApplicationPolicy
      def index?
        true
      end

      private

      def based_scope
        authorized_scope(User, type: :all)
      end
    end
  end
end

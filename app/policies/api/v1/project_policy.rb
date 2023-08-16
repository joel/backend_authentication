# frozen_string_literal: true

module Api
  module V1
    class ProjectPolicy < ApplicationPolicy
      def index?
        true
      end

      def show?
        true
      end

      def update?
        user.id == record.user_id
      end

      def create?
        true
      end

      private

      def based_scope
        authorized_scope(Project, type: :relation)
      end
    end
  end
end

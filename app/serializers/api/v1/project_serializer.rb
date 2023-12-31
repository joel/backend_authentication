# frozen_string_literal: true

module Api
  module V1
    class ProjectSerializer
      include JSONAPI::Serializer

      set_type :project
      set_id :id

      attributes :name

      attributes :created_at
      attributes :updated_at

      belongs_to :user
      has_many :deliverables
    end
  end
end

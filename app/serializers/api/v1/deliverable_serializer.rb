# frozen_string_literal: true

module Api
  module V1
    class DeliverableSerializer
      include JSONAPI::Serializer

      set_type :deliverable
      set_id :id

      attributes :name
      attributes :due_at
      attributes :status
      attributes :active
      attributes :metadata

      attributes :created_at
      attributes :updated_at

      belongs_to :project
    end
  end
end

# frozen_string_literal: true

module Api
  module V1
    class ProjectSerializer
      include JSONAPI::Serializer

      set_type :project # optional
      set_id :id # optional
      attributes :name
      # belongs_to :user
    end
  end
end

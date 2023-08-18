# frozen_string_literal: true

module Api
  module V1
    class UserSerializer
      include JSONAPI::Serializer

      set_type :user
      set_id :id

      attributes :name
      attributes :email
      attributes :username

      attributes :created_at
      attributes :updated_at

      has_many :projects
    end
  end
end

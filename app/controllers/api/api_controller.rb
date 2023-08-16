# frozen_string_literal: true

module Api
  class ApiController < ApplicationController
    include JSONAPI::Fetching
    include JSONAPI::Filtering
    include JSONAPI::Pagination
    include JSONAPI::Deserialization
    include JSONAPI::Errors

    before_action :api_version
    after_action :set_version_header

    include ActionPolicy::Controller
    authorize :user, through: :current_user

    verify_authorized except: :index

    protected

    def api_version
      return unless request.headers["Accept"]&.match(ApiVersion::API_REGEXP)

      Current.api_version = Regexp.last_match[:version].to_f
    end

    def set_version_header
      response.headers["X-Acme-Api-Version"] = Current.api_version
    end
  end
end

# frozen_string_literal: true

module Api
  class ApiController < ApplicationController
    before_action :api_version
    after_action :set_version_header

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

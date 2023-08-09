# frozen_string_literal: true

class ApplicationController < ActionController::API
  include JwtWebToken

  before_action :authenticate_request

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { error: e.message }, status: :not_found
  end

  private

  def authenticate_request
    header  = request.headers["Authorization"]
    token   = header.split.last if header
    decoded = jwt_decode(token:)

    Current.user = User.find(decoded[0]["user_id"]) if decoded

    nil
  end
end

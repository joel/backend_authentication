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

    unless decoded
      render json: { error: "unauthorized, invalid token" }, status: :unauthorized
      return
    end

    user = User.find(decoded["user_id"])
    unless user
      render json: { error: "unauthorized, user not found!" }, status: :unauthorized
      return
    end

    Current.user = user
  end
end

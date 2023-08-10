# frozen_string_literal: true

require "jwt"

module JwtWebToken
  extend ActiveSupport::Concern

  def jwt_encode(payload:, expire: 7.days.from_now)
    payload[:exp] = expire.to_i
    JWT.encode(payload, Rails.application.credentials.secret_key_base, "HS256")
  end

  def jwt_decode(token:)
    return unless token

    payload, options = JWT.decode(token, Rails.application.credentials.secret_key_base, true, { algorithm: "HS256" })

    JwtToken.new(payload:, options:)
  end
end

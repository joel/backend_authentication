# frozen_string_literal: true

class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = jwt_encode(payload: { user_id: user.id })
      render json: { token: }
    else
      render json: { error: "unauthorized, identification email password failed!" }, status: :unauthorized
    end
  end
end

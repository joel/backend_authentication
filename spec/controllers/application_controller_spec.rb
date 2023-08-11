# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationController do
  controller do
    def index
      render json: { message: "Hello World" }
    end
  end

  before do
    routes.draw { get "index" => "anonymous#index" }
  end

  context "with token" do
    before do
      request.headers["Authorization"] = headers["Authorization"]
    end

    context "with valid token" do
      let(:user) { create(:user) }
      let(:headers) do
        {
          "Authorization" => "Bearer #{JWT.encode({ user_id: user.id }, Rails.application.credentials.secret_key_base, 'HS256')}"
        }
      end

      it "authenticate the user and set Current.user" do
        expect(Current).to receive(:user=).with(user)
        allow(Current).to receive(:user).and_return(user)
        get :index
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid token" do
      let(:headers) do
        {
          "Authorization" => "Bearer WRONG_TOKEN"
        }
      end

      it "does nothing" do
        expect(Current).not_to receive(:user=)
        get :index
        expect(response).to have_http_status(:unauthorized)
        expect(response.parsed_body).to match({ "error" => "unauthorized, invalid token" })
      end
    end
  end

  context "without token" do
    it "does nothing" do
      expect(Current).not_to receive(:user=)
      get :index
      expect(response).to have_http_status(:unauthorized)
      expect(response.parsed_body).to match({ "error" => "unauthorized, invalid token" })
    end
  end
end

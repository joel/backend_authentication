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

  context "with authorization header" do
    let(:user) { create(:user) }
    let(:valid_headers) do
      {
        "Authorization" => "Bearer #{JWT.encode({ user_id: user.id }, Rails.application.credentials.secret_key_base, 'HS256')}"
      }
    end

    before do
      request.headers["Authorization"] = valid_headers["Authorization"]
    end

    it "set the authorized user" do
      expect(Current).to receive(:user=).with(user) # rubocop:disable RSpec/MessageSpies
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  context "without authorization header" do
    it "does nothing" do
      expect(Current).not_to receive(:user=) # rubocop:disable RSpec/MessageSpies
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  context "with invalid authorization header" do
    let(:valid_headers) do
      {
        "Authorization" => "Bearer #{JWT.encode({ user_id: 42 }, Rails.application.credentials.secret_key_base, 'HS256')}"
      }
    end

    before do
      request.headers["Authorization"] = valid_headers["Authorization"]
    end

    it "does nothing" do
      expect(Current).not_to receive(:user=) # rubocop:disable RSpec/MessageSpies
      get :index
      expect(response).to have_http_status(:not_found)
    end
  end
end

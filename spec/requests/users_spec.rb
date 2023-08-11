# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/users" do
  let(:user) { create(:user) }

  let(:valid_headers) do
    {
      "Authorization" => "Bearer #{JWT.encode({ user_id: user.id }, Rails.application.credentials.secret_key_base, 'HS256')}"
    }
  end

  describe "GET /index" do
    it "renders a successful response" do
      get users_url, headers: valid_headers, as: :json
      expect(response).to be_successful
      expect(response.parsed_body).to match([JSON.parse(user.to_json(only: %i[id email name username created_at updated_at password_digest]))])
    end
  end
end

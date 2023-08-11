# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/api/v2/users" do
  let(:user) { create(:user) }

  let(:valid_headers) do
    {
      "Authorization" => "Bearer #{JWT.encode({ user_id: user.id }, Rails.application.credentials.secret_key_base, 'HS256')}",
      "Content-Type" => "application/json",
      "Accept" => "application/x-api-v2+json"
    }
  end

  describe "GET /index" do
    it "renders a successful response" do
      get api_users_url, headers: valid_headers, as: :json
      expect(response).to be_successful
      expect(response.parsed_body).to match([JSON.parse(user.to_json(only: %i[id name email]))])
      expect(response.headers["X-Acme-Api-Version"]).to be(2.0)
    end
  end
end

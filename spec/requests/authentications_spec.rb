# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/login" do
  let(:attributes) do
    attributes_for(:user).slice(:email, :password)
  end

  let(:valid_attributes) do
    attributes
  end

  let(:invalid_attributes) do
    attributes_for(:user).slice(:email, :password)
  end

  let(:valid_headers) { {} }

  before do
    User.create!(
      build(:user).attributes.merge(
        {
          "email" => attributes[:email],
          "password" => attributes[:password],
          "password_confirmation" => attributes[:password]
        }
      )
    )
  end

  describe "POST /create" do
    context "with valid identification parameters" do
      it "returns a valid token" do
        post login_url, params: valid_attributes, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
        expect(response.parsed_body["token"]).to match(/\A[a-zA-Z0-9\-_]+\.[a-zA-Z0-9\-_]+\.[a-zA-Z0-9\-_]+/)
      end
    end

    context "with invalid identification parameters" do
      it "renders a JSON response with errors" do
        post login_url, params: invalid_attributes, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unauthorized)
        expect(response.content_type).to match(a_string_including("application/json"))
        expect(response.parsed_body).to match({ "error" => "unauthorized, identification email password failed!" })
      end
    end
  end
end

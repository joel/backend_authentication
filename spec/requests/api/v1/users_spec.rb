# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/api/v1/users" do
  before { travel_to Date.new(2004, 11, 24) }

  context "with an authenticated user" do
    let(:user) do
      create(
        :user,
        id: "01H7YRXCXK0M10W3RC045GW001",
        name: "John",
        email: "teressa@mullerbuckridge.us",
        username: "dia.hyatt"
      )
    end

    let(:project) { create(:project, id: "01H7YRXCXK0M10W3RC045GW000", name: "Manhattan", user:) }

    let(:valid_headers) do
      {
        "Authorization" => "Bearer #{JWT.encode({ user_id: user.id }, Rails.application.credentials.secret_key_base, 'HS256')}",
        "Content-Type" => "application/json",
        "Accept" => "application/x-api-v1+json"
      }
    end

    before { project }

    context "with user" do
      describe "GET /index" do
        before { get api_users_url, headers: valid_headers, as: :json }

        it "renders a successful response" do
          expect(response).to be_successful
        end

        it "renders a valid JSON" do
          expect(JSON.parse(response.body)).to eql( # rubocop:disable Rails/ResponseParsedBody
            {
              "data" => [
                {
                  "id" => "01H7YRXCXK0M10W3RC045GW001",
                  "type" => "user",
                  "attributes" => {
                    "name" => "John",
                    "email" => "teressa@mullerbuckridge.us",
                    "username" => "dia.hyatt",
                    "created_at" => "2004-11-24T00:00:00.000Z",
                    "updated_at" => "2004-11-24T00:00:00.000Z"
                  },
                  "relationships" => {
                    "projects" => {
                      "data" => [
                        {
                          "id" => "01H7YRXCXK0M10W3RC045GW000",
                          "type" => "project"
                        }
                      ]
                    }
                  }
                }
              ]
            }
          )
        end

        it "renders Response Header API Versio" do
          expect(response.headers["X-Acme-Api-Version"]).to be(1.0)
        end
      end
    end
  end
end

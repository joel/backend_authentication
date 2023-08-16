# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/api/v1/projects" do
  let(:user) { create(:user) }

  let(:valid_headers) do
    {
      "Authorization" => "Bearer #{JWT.encode({ user_id: user.id }, Rails.application.credentials.secret_key_base, 'HS256')}",
      "Content-Type" => "application/json",
      "Accept" => "application/x-api-v1+json"
    }
  end

  let(:id) { "01H7YRXCXK0M10W3RC045GW000" }
  let(:name) { "Manhattan" }
  let(:project) { create(:project, id:, name:, user:) }

  before { project }

  describe "GET /index" do
    before do
      get api_projects_url("sort" => "name"), headers: valid_headers, as: :json
    end

    it "renders a successful response" do
      expect(response).to be_successful
    end

    it "renders a valid JSON" do
      expect(JSON.parse(response.body)).to eql( # rubocop:disable Rails/ResponseParsedBody
        {
          "meta" => { "total" => 1 },
          "links" => {
            "self" => "http://www.example.com/api/projects?sort=name",
            "current" => "http://www.example.com/api/projects?page[number]=1&sort=name"
          },
          "data" => [
            {
              "attributes" =>
                {
                  "name" => "Manhattan"
                },
              "id" => "01H7YRXCXK0M10W3RC045GW000",
              "type" => "project"
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

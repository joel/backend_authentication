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
  let(:valid_attributes) do
    attributes_for(:project)
  end

  let(:invalid_attributes) do
    valid_attributes.merge({ name: "" })
  end

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

  describe "GET /show" do
    before do
      get api_project_url(project), headers: valid_headers, as: :json
    end

    it "renders a successful response" do
      expect(response).to be_successful
    end

    it "renders a valid JSON" do
      expect(JSON.parse(response.body)).to eql( # rubocop:disable Rails/ResponseParsedBody
        {
          "data" => {
            "id" => "01H7YRXCXK0M10W3RC045GW000",
            "type" => "project",
            "attributes" => {
              "name" => "Manhattan"
            }
          },
          "links" => {
            "self" => "http://www.example.com/api/projects/01H7YRXCXK0M10W3RC045GW000"
          }
        }
      )
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      subject(:create_project_call) do
        post api_projects_url, params: { project: valid_attributes }, headers: valid_headers, as: :json
      end

      let(:created_project) { Project.last }

      it "creates a new Project" do
        expect do
          create_project_call
        end.to change(Project, :count).by(1)
      end

      it "renders a JSON response with the new project" do
        create_project_call
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/vnd.api+json"))
      end

      it "assigns to the current user" do
        create_project_call
        expect(created_project.user).to eq(user)
      end

      it "renders a valid JSON" do
        create_project_call

        expect(JSON.parse(response.body)).to eql( # rubocop:disable Rails/ResponseParsedBody
          {
            "data" => {
              "id" => valid_attributes[:id],
              "type" => "project",
              "attributes" => {
                "name" => valid_attributes[:name]
              }
            },
            "links" => {
              "self" => "http://www.example.com/api/projects"
            }
          }
        )
      end
    end

    context "with invalid parameters" do
      subject(:create_project_call) do
        post api_projects_url, params: { project: invalid_attributes }, headers: valid_headers, as: :json
      end

      it "does not create a new Project" do
        expect do
          create_project_call
        end.not_to change(Project, :count)
      end

      it "renders a JSON response with errors for the new project" do
        create_project_call
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/vnd.api+json"))
      end

      it "renders a valid JSON" do
        create_project_call

        expect(JSON.parse(response.body)).to eql( # rubocop:disable Rails/ResponseParsedBody
          {
            "errors" => [
              {
                "status" => "422",
                "source" => { "pointer" => "/data/attributes/name" },
                "title" => "Unprocessable Entity",
                "detail" => "Name can't be blank",
                "code" => "blank"
              }
            ]
          }
        )
      end
    end
  end
end

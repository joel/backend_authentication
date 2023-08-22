# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/api/v1/projects" do
  before do
    travel_to Date.new(2004, 11, 24)
  end

  context "with an authenticated user" do
    let(:user) { create(:user, id: "01H7YRXCXK0M10W3RC045GW001") }

    let(:valid_headers) do
      {
        "Authorization" => "Bearer #{JWT.encode({ user_id: user.id }, Rails.application.credentials.secret_key_base, 'HS256')}",
        "Content-Type" => "application/json",
        "Accept" => "application/x-api-v1+json"
      }
    end

    let(:id) { "01H7YRXCXK0M10W3RC045GW000" }

    context "with project" do
      let(:name) { "Manhattan" }
      let(:project) { create(:project, id:, name:, user:) }
      let(:json_api_options) { {} }

      before { project }

      describe "GET /index" do
        subject(:request) do
          get api_projects_url(json_api_options), headers: valid_headers, as: :json
        end

        context "with a collection of projects" do
          before do
            project.update(name: "A")
            create(:project, name: "B", user:)
            create(:project, name: "C", user:)
          end

          context "when sorted by name asc" do
            let(:json_api_options) { { sort: "name" } }

            before { request }

            it "renders projects in alphabetic order" do
              expect(
                JSON.parse(response.body)["data"].map { |e| e["attributes"]["name"] }
              ).to eql(%w[A B C])
            end
          end

          context "when sorted by name desc" do
            let(:json_api_options) { { sort: "-name" } }

            before { request }

            it "renders projects in alphabetic order" do
              expect(
                JSON.parse(response.body)["data"].map { |e| e["attributes"]["name"] }
              ).to eql(%w[A B C].reverse)
            end
          end
        end

        context "when no pagination" do
          before { request }

          it "renders a successful response" do
            expect(response).to be_successful
          end

          it "renders a valid JSON" do
            expect(JSON.parse(response.body)).to eql(
              {
                "meta" => { "total" => 1 },
                "links" => {
                  "self" => "http://www.example.com/api/projects",
                  "current" => "http://www.example.com/api/projects?page[number]=1"
                },
                "data" => [
                  {
                    "attributes" => {
                      "name" => "Manhattan",
                      "created_at" => "2004-11-24T00:00:00.000Z",
                      "updated_at" => "2004-11-24T00:00:00.000Z"
                    },
                    "relationships" => {
                      "user" => {
                        "data" => {
                          "id" => "01H7YRXCXK0M10W3RC045GW001",
                          "type" => "user"
                        }
                      }
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

      describe "GET /show" do
        before do
          get api_project_url(project), headers: valid_headers, as: :json
        end

        it "renders a successful response" do
          expect(response).to be_successful
        end

        it "renders a valid JSON" do
          expect(JSON.parse(response.body)).to eql(
            {
              "data" => {
                "id" => "01H7YRXCXK0M10W3RC045GW000",
                "type" => "project",
                "attributes" => {
                  "name" => "Manhattan",
                  "created_at" => "2004-11-24T00:00:00.000Z",
                  "updated_at" => "2004-11-24T00:00:00.000Z"
                },
                "relationships" => {
                  "user" => {
                    "data" => {
                      "id" => "01H7YRXCXK0M10W3RC045GW001",
                      "type" => "user"
                    }
                  }
                }
              },
              "links" => {
                "self" => "http://www.example.com/api/projects/01H7YRXCXK0M10W3RC045GW000"
              }
            }
          )
        end
      end

      describe "PUT /update" do
        subject(:update_project_call) do
          put api_project_url(project), params: attributes, headers: valid_headers, as: :json
        end

        let(:attributes) do
          {
            data: {
              id:,
              type: "project",
              attributes: {
                name: new_name
              },
              relationships: {
                user: {
                  data: {
                    type: "user",
                    id: user.id
                  }
                }
              }
            }
          }
        end

        context "with valid parameters" do
          let(:new_name) { "Brooklyn" }

          it "renders a JSON response with the new project" do
            update_project_call
            expect(response).to have_http_status(:ok)
            expect(response.content_type).to match(a_string_including("application/vnd.api+json"))
          end

          it "renders a valid JSON" do
            update_project_call

            expect(JSON.parse(response.body)).to eql(
              {
                "data" => {
                  "id" => id,
                  "type" => "project",
                  "attributes" => {
                    "name" => "Brooklyn",
                    "created_at" => "2004-11-24T00:00:00.000Z",
                    "updated_at" => "2004-11-24T00:00:00.000Z"
                  },
                  "relationships" => {
                    "user" => {
                      "data" => {
                        "id" => "01H7YRXCXK0M10W3RC045GW001",
                        "type" => "user"
                      }
                    }
                  }
                },
                "links" => {
                  "self" => "http://www.example.com/api/projects/#{id}"
                }
              }
            )
          end
        end

        context "with invalid parameters" do
          let(:new_name) { "" }

          it "renders a JSON response with errors for the new project" do
            update_project_call
            expect(response).to have_http_status(:unprocessable_entity)
            expect(response.content_type).to match(a_string_including("application/vnd.api+json"))
          end

          it "renders a valid JSON" do
            update_project_call

            expect(JSON.parse(response.body)).to eql(
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

    context "without project" do
      describe "POST /create" do
        subject(:create_project_call) do
          post api_projects_url, params: attributes, headers: valid_headers, as: :json
        end

        let(:attributes) do
          {
            data: {
              id:,
              type: "project",
              attributes: {
                name:
              },
              relationships: {
                user: {
                  data: {
                    type: "user",
                    id: user.id
                  }
                }
              }
            }
          }
        end

        context "with valid parameters" do
          let(:name) { "Brooklyn" }
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

            expect(JSON.parse(response.body)).to eql(
              {
                "data" => {
                  "id" => id,
                  "type" => "project",
                  "attributes" => {
                    "name" => name,
                    "created_at" => "2004-11-24T00:00:00.000Z",
                    "updated_at" => "2004-11-24T00:00:00.000Z"
                  },
                  "relationships" => {
                    "user" => {
                      "data" => {
                        "id" => "01H7YRXCXK0M10W3RC045GW001",
                        "type" => "user"
                      }
                    }
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
          let(:name) { "" }

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

            expect(JSON.parse(response.body)).to eql(
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
  end
end

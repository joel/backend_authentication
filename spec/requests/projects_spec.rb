# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/projects" do
  let(:user) { create(:user) }

  let(:valid_headers) do
    {
      "Authorization" => "Bearer #{JWT.encode({ user_id: user.id }, Rails.application.credentials.secret_key_base, 'HS256')}"
    }
  end

  let(:valid_attributes) do
    attributes_for(:project)
  end

  let(:invalid_attributes) do
    valid_attributes.merge({ name: "" })
  end

  describe "GET /index" do
    let(:project) { create(:project, user:) }

    before { project }

    it "renders a successful response" do
      get projects_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    let(:project) { create(:project, user:) }

    before { project }

    it "renders a successful response" do
      get project_url(project), headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      let(:created_project) { Project.last }

      it "creates a new Project" do
        expect do
          post projects_url, params: { project: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Project, :count).by(1)
      end

      it "renders a JSON response with the new project" do
        post projects_url, params: { project: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end

      it "assigns to the current user" do
        post projects_url, params: { project: valid_attributes }, headers: valid_headers, as: :json
        expect(created_project.user).to eq(user)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Project" do
        expect do
          post projects_url, params: { project: invalid_attributes }, as: :json
        end.not_to change(Project, :count)
      end

      it "renders a JSON response with errors for the new project" do
        post projects_url, params: { project: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    let(:project) { create(:project, user:) }

    before { project }

    context "with valid parameters" do
      let(:new_attributes) do
        attributes_for(:project).slice(:name)
      end

      it "updates the requested project" do
        expect do
          patch project_url(project), params: { project: new_attributes }, headers: valid_headers, as: :json
        end.to change { project.reload.name }.to(new_attributes[:name])
      end

      it "renders a JSON response with the project" do
        patch project_url(project), params: { project: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the project" do
        patch project_url(project), params: { project: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    let(:project) { create(:project, user:) }

    before { project }

    it "destroys the requested project" do
      expect do
        delete project_url(project), headers: valid_headers, as: :json
      end.to change(Project, :count).by(-1)
    end
  end
end

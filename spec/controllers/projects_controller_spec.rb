# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProjectsController do
  let(:user) { create(:user) }

  let(:valid_headers) do
    {
      "Authorization" => "Bearer #{JWT.encode({ user_id: user.id }, Rails.application.credentials.secret_key_base, 'HS256')}"
    }
  end

  let(:valid_session) { {} }

  before do
    request.headers["Authorization"] = valid_headers["Authorization"]
  end

  describe "GET #index" do
    let(:project) { create(:project, user:) }

    before { project }

    it "returns a success response" do
      get :index, params: {}, session: valid_session

      expect(response).to be_successful
    end
  end
end

# frozen_string_literal: true

require "rails_helper"

module Api
  module V1
    RSpec.describe ProjectSerializer do
      subject(:serializer) do
        JSON.parse described_class.new(project).serializable_hash.to_json
      end

      let(:project) do
        travel_to Date.new(2004, 11, 24) do
          build_stubbed(
            :project,
            id: "01H7YRXCXK0M10W3RC045GW000",
            name: "Manhattan",
            user: build_stubbed(
              :user,
              id: "01H7YRXCXK0M10W3RC045GW001"
            )
          )
        end
      end

      it "has valid format" do
        expect(serializer).to eql(
          {
            "data" =>
            {
              "attributes" =>
              {
                "name" => "Manhattan",
                "created_at" => "2004-11-24T00:00:00.000Z",
                "updated_at" => "2004-11-24T00:00:00.000Z"
              },
              "id" => "01H7YRXCXK0M10W3RC045GW000",
              "type" => "project",
              "relationships" => {
                "user" => {
                  "data" => {
                    "id" => "01H7YRXCXK0M10W3RC045GW001",
                    "type" => "user"
                  }
                }
              }
            }
          }
        )
      end
    end
  end
end

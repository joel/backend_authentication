# frozen_string_literal: true

require "rails_helper"

module Api
  module V1
    RSpec.describe ProjectSerializer do
      subject(:serializer) do
        JSON.parse described_class.new(project).serializable_hash.to_json
      end

      let(:id) { "01H7YRXCXK0M10W3RC045GW000" }
      let(:name) { "Manhattan" }
      let(:project) { create(:project, id:, name:) }

      it "has valid format" do
        expect(serializer).to eql(
          {
            "data" =>
            {
              "attributes" =>
              {
                "name" => "Manhattan"
              },
              "id" => "01H7YRXCXK0M10W3RC045GW000",
              "type" => "project"
            }
          }
        )
      end
    end
  end
end

# frozen_string_literal: true

require "rails_helper"

module Api
  module V1
    RSpec.describe UserSerializer do
      subject(:serializer) do
        JSON.parse described_class.new(user).serializable_hash.to_json
      end

      let(:user) do
        travel_to Date.new(2004, 11, 24) do
          build_stubbed(
            :user,
            id: "01H7YRXCXK0M10W3RC045GW000",
            name: "Rema Walter",
            email: "tanja@crooksstoltenberg.ca",
            username: "paris_frami"
          )
        end
      end

      it "has valid format" do
        expect(serializer).to eql(
          {
            "data" => {
              "id" => "01H7YRXCXK0M10W3RC045GW000",
              "type" => "user",
              "attributes" => {
                "name" => "Rema Walter",
                "email" => "tanja@crooksstoltenberg.ca",
                "username" => "paris_frami",
                "created_at" => "2004-11-24T00:00:00.000Z",
                "updated_at" => "2004-11-24T00:00:00.000Z"

              },
              "relationships" => {
                "projects" => {
                  "data" => []
                }
              }
            }
          }
        )
      end
    end
  end
end

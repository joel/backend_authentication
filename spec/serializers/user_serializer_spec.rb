# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserSerializer do
  subject(:serializer) do
    serializer = described_class.new
    serializer.name = "John"
    serializer.serializable_hash
  end

  it "has valid format" do
    expect(serializer).to eql(
      {
        "name" => "John"
      }
    )
  end

  context "with model" do
    it "has valid format" do
      expect(User.new(name: "John").to_json(only: :name)).to eql(
        {
          "name" => "John"
        }.to_json
      )
    end
  end
end

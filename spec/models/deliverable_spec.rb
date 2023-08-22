# frozen_string_literal: true

require "rails_helper"

RSpec.describe Deliverable do
  context "with validations" do
    it "is valid with valid attributes" do
      expect(build(:deliverable)).to be_valid
    end
  end

  context "with state machines" do
    it "has a default status of open" do
      expect(build(:deliverable).status).to eq("open")
    end

    it "can transition from open to started" do
      deliverable = create(:deliverable)
      deliverable.started!
      expect(deliverable.status).to eq("started")
      expect(deliverable.read_attribute_before_type_cast("status")).to eq(1)
    end
  end
end

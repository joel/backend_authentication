# frozen_string_literal: true

require "rails_helper"

RSpec.describe Project do
  context "with validations" do
    it "is valid with valid attributes" do
      expect(build(:project)).to be_valid
    end
  end
end

# frozen_string_literal: true

require "rails_helper"

RSpec.describe User do
  context "with validations" do
    it "is valid with valid attributes" do
      expect(build(:user)).to be_valid
    end
  end
end

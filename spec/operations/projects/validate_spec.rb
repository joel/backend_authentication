# frozen_string_literal: true

require "rails_helper"

module Projects
  RSpec.describe Validate do
    let(:attributes) { attributes_for(:project).merge(user_id: SecureRandom.uuid) }

    subject(:operation) { described_class.new }

    context "when valid" do
      it "returns success" do
        expect(operation.call(attributes)).to be_success
      end
    end

    context "when invalid" do
      it "returns failure" do
        expect(operation.call(attributes.merge(id: nil))).to be_failure
      end
    end
  end
end

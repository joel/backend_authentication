# frozen_string_literal: true

require "rails_helper"

module Api
  module V1
    RSpec.describe ProjectPolicy do
      let(:user)    { build_stubbed(:user) }
      let(:project) { build_stubbed(:project, user:) }

      describe "permissions" do
        subject(:authorization) { policy.apply(:update?) }

        describe "#update?" do
          context "when user is not the owner" do
            let(:policy) { described_class.new(project, user: build_stubbed(:user)) }

            it "expects not to be permitted" do
              expect(authorization).to be_falsy
            end
          end

          context "when user is the owner" do
            let(:policy) { described_class.new(project, user:) }

            it "expects be permitted" do
              expect(authorization).to be_truthy
            end
          end
        end
      end
    end
  end
end

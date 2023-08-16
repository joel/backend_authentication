# frozen_string_literal: true

require "rails_helper"

module Api
  module V1
    RSpec.describe ProjectPolicy do
      describe "permissions" do
        let(:user) { build_stubbed(:user) }
        let(:project) { build_stubbed(:project, user:) }

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

      describe "scope" do
        let(:user) { create(:user) }
        let(:target_scope) { Project.where(name: %w[A B]).order(:name) }
        let(:project) { create(:project, user:) }

        before do
          create(:project, name: "A", user:)
          create(:project, name: "B")
        end

        subject(:result) { policy.apply_scope(target_scope, type: :relation).pluck(:name) }

        context "when user is not the owner" do
          let(:policy) { described_class.new(project, user: create(:user)) }

          it "expects to return an empty collection" do
            expect(result).to be_empty
          end
        end

        context "when user is the owner" do
          let(:policy) { described_class.new(project, user:) }

          it "expects to return his projects" do
            expect(result).to eq(%w[A])
          end
        end
      end
    end
  end
end

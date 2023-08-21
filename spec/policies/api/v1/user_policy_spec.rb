# frozen_string_literal: true

require "rails_helper"

module Api
  module V1
    RSpec.describe UserPolicy do
      # describe "permissions" do
      #   let(:user) { build_stubbed(:user) }
      #   let(:project) { build_stubbed(:project, user:) }

      #   subject(:authorization) { policy.apply(:update?) }

      #   describe "#update?" do
      #     context "when user is not the owner" do
      #       let(:policy) { described_class.new(project, user: build_stubbed(:user)) }

      #       it "expects not to be permitted" do
      #         expect(authorization).to be_falsy
      #       end
      #     end

      #     context "when user is the owner" do
      #       let(:policy) { described_class.new(project, user:) }

      #       it "expects be permitted" do
      #         expect(authorization).to be_truthy
      #       end
      #     end
      #   end
      # end

      describe "scope" do
        let(:user) { create(:user, name: "John") }
        let(:target_scope) { User.all }

        before { user }

        subject(:result) { policy.apply_scope(target_scope, type: :all).pluck(:name) }

        context "when user is the owner" do
          let(:policy) { described_class.new(user, user:) }

          it "expects to return all users" do
            expect(result).to eq(%w[John])
          end
        end
      end
    end
  end
end

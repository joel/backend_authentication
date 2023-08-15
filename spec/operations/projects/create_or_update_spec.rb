# frozen_string_literal: true

require "rails_helper"

module Projects
  RSpec.describe CreateOrUpdate do
    let(:user) { create(:user) }
    let(:attributes) { attributes_for(:project).merge(user_id: user.id, id:) }

    subject(:operation) { described_class.new }

    context "when create" do
      let(:id) { ArUlid.configuration.generator.generate_id }

      it do
        expect do
          operation.call(attributes)
        end.to change(Project, :count).by(1)
      end
    end

    context "when update" do
      before { id }

      let(:project) { create(:project) }
      let(:id) { project.id }

      it do
        expect do
          operation.call(attributes)
        end.not_to change(Project, :count)
      end

      it "does change the name" do
        expect do
          operation.call(attributes)
        end.to change {
          project.reload.name
        }.to(attributes[:name])
      end
    end
  end
end

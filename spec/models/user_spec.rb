# frozen_string_literal: true

require "rails_helper"

RSpec.describe User do
  context "with validations" do
    it "is valid with valid attributes" do
      expect(build(:user)).to be_valid
    end
  end

  context "with associations" do
    it { expect(described_class.reflect_on_association(:projects).macro).to eq(:has_many) }
    it { expect(described_class.reflect_on_association(:projects).options[:dependent]).to eq(:destroy) }
    it { expect(described_class.reflect_on_association(:projects).options[:inverse_of]).to eq(:user) }

    it "#inverse_of" do
      user = create(:user, :with_projects)
      project = user.projects.first

      expect(project.user).not_to be_nil
      expect(project.user).to eq(user)
    end
  end

  context "when create or update" do
    let(:attributes) { attributes_for(:user).merge(id:) }
    let(:instance) do
      described_class.find_by(id:) || described_class.new
    end

    context "when create" do
      let(:id) { ArUlid.configuration.generator.generate_id }

      it do
        expect do
          instance.update(attributes)
        end.to change(described_class, :count).by(1)
      end

      it "does change the id" do
        expect do
          instance.update(attributes)
        end.to change(instance, :id).to(id)
      end
    end

    context "when update" do
      before { id }

      let(:id) { create(:user).id }

      it do
        expect do
          instance.update(attributes)
        end.not_to change(described_class, :count)
      end
    end
  end
end

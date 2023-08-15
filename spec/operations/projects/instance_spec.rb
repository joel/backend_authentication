# frozen_string_literal: true

require "rails_helper"

module Projects
  RSpec.describe Instance do
    let(:user)       { create(:user) }
    let(:attributes) { attributes_for(:project).merge(user_id: user.id) }
    let(:instance)   { operation[:instance] }
    let(:input)      { operation[:input] }

    subject(:operation) { described_class.new.call(given_attributes).success }

    context "when instance exists" do
      let(:given_attributes) { attributes.merge(id: create(:project).id) }

      it do
        expect(instance).to be_a(Project)
        expect(instance).to be_persisted
        expect(input.to_h).to eq(given_attributes)
      end
    end

    context "when instance does not exist" do
      let(:given_attributes) { attributes.merge(id: SecureRandom.uuid) }

      it do
        expect(instance).to be_a(Project)
        expect(instance).to be_new_record
        expect(input.to_h).to eq(given_attributes)
      end
    end
  end
end

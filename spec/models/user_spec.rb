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
end

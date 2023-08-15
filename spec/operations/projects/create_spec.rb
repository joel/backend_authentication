# frozen_string_literal: true

require "rails_helper"

module Projects
  RSpec.describe Create do
    let(:user) { create(:user) }
    let(:attributes) { attributes_for(:project).merge(user_id: user.id) }

    subject(:operation) { described_class.new }

    it do
      expect do
        operation.call(attributes)
      end.to change(Project, :count).by(1)
    end
  end
end

# frozen_string_literal: true

require "rails_helper"

module Projects
  RSpec.describe Update do
    let(:project) { create(:project) }
    let(:new_name) { "New name" }
    let(:attributes) { { name: new_name, id: project.id } }

    subject(:operation) { described_class.new }

    it do
      expect do
        operation.call(attributes)
      end.to change {
        project.reload.name
      }.from(project.name).to(new_name)
    end
  end
end

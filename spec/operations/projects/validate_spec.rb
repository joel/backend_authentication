# frozen_string_literal: true

require "rails_helper"

module Projects
  RSpec.describe Validate do
    let(:user_id) { SecureRandom.uuid }
    let(:attributes) { attributes_for(:project).merge(user_id:) }

    subject(:operation) { described_class.new }

    it do
      expect(operation.call(attributes)).to be_success
    end
  end
end

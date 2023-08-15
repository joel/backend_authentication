# frozen_string_literal: true

require "dry/transaction/operation"

module Projects
  class Instance
    include Dry::Transaction::Operation

    def call(input)
      described_class.find_by(id: input[:id]) || described_class
      project = Project.new(input)
      project.save!

      Success(project)
    end
  end
end

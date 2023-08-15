# frozen_string_literal: true

require "dry/transaction/operation"

module Projects
  class Create
    include Dry::Transaction::Operation

    def call(input)
      project = Project.new(input)
      project.save!

      Success(project)
    end
  end
end

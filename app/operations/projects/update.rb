# frozen_string_literal: true

require "dry/transaction/operation"

module Projects
  class Update
    include Dry::Transaction::Operation

    def call(input)
      project = Project.find_by(id: input[:id])
      return Failure("Project not found") unless project

      project.update!(input)

      Success(project)
    end
  end
end

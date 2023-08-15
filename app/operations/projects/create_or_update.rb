# frozen_string_literal: true

require "dry/transaction/operation"

module Projects
  class CreateOrUpdate
    include Dry::Transaction(container: OperationRegister)

    step :validate, with: "projects.validate"
    step :create, with: "projects.create"
  end
end

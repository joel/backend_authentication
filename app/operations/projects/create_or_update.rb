# frozen_string_literal: true

require "dry/transaction/operation"

module Projects
  class CreateOrUpdate
    include Dry::Transaction(container: OperationRegister)

    step :validate, with: "projects.validate"
    step :find_or_initialize, with: "projects.instance"
    step :create_or_update, with: "projects.update"
  end
end

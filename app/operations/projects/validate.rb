# frozen_string_literal: true

require "dry/transaction/operation"
require "dry/validation"
require "dry/validation/contract"

module Projects
  class Validate
    include Dry::Transaction::Operation

    def call(input)
      params = if Project.find_by(id: input[:id])
                 UpdateContract.new.call(input)
               else
                 CreateContract.new.call(input)
               end

      return Failure(params.errors) if params.failure?

      Success(input)
    end
  end
end

# frozen_string_literal: true

require "dry/transaction/operation"
require "dry/validation"
require "dry/validation/contract"

module Projects
  class Validate
    include Dry::Transaction::Operation

    def call(input)
      params = Param.new.call(input)
      return Failure(params.errors) if params.failure?

      Success(input)
    end
  end
end

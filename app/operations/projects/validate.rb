# frozen_string_literal: true

require "dry/transaction/operation"
require "dry/validation"
require "dry/validation/contract"

module Projects
  class Validate
    include Dry::Transaction::Operation

    def call(input)
      Param.new.call(input)

      Success(input)
    end
  end
end

# frozen_string_literal: true

require "dry/transaction/operation"
require "dry/monads"

module Projects
  class Instance
    include Dry::Transaction::Operation

    def call(input)
      instance = Project.find_by(id: input[:id]) || Project.new
      Success({ instance:, input: })
    end
  end
end

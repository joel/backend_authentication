# frozen_string_literal: true

module Projects
  class UpdateContract < Dry::Validation::Contract
    params(UpdateSchema)
  end
end

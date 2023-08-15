# frozen_string_literal: true

module Projects
  class CreateContract < Dry::Validation::Contract
    params(UpdateSchema) do
      required(:user_id).filled(:string)
    end
  end
end

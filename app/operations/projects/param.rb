# frozen_string_literal: true

module Projects
  class Param < Dry::Validation::Contract
    params do
      required(:name).filled(:string)
      required(:user_id).filled(:string)
    end
  end
end

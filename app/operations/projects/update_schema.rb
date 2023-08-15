# frozen_string_literal: true

module Projects
  UpdateSchema = Dry::Schema.Params do
    required(:id).filled(:string)
    required(:name).filled(:string)
  end
end

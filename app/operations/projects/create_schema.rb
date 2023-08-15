# frozen_string_literal: true

module Projects
  CreateSchema = Dry::Schema.Params do
    required(:id).filled(:string)
    required(:name).filled(:string)
    required(:user_id).filled(:string)
  end
end

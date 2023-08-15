# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    id { ArUlid.configuration.generator.generate_id }
    name { FFaker::Name.unique.name }
    user
  end
end

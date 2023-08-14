# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    name { FFaker::Name.unique.name }
    user
  end
end

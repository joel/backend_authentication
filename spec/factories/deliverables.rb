# frozen_string_literal: true

FactoryBot.define do
  factory :deliverable do
    name { FFaker::Name.unique.name }
    project
    due_at { rand(1..10).days.from_now }
    status { :open }
    active { true }
    metadata { { foo: :bar } }
  end
end

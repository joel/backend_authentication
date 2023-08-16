# frozen_string_literal: true

class ApplicationPolicy < ActionPolicy::Base
  authorize :user

  scope_for :relation do |relation|
    relation.where(user:)
  end
end

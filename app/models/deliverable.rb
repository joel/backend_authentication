# frozen_string_literal: true

class ::Deliverable < ApplicationRecord
  has_ulid

  belongs_to :project

  enum status: { open: 0, started: 1, closed: 2 }

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name due_at status active metadata created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[project]
  end
end

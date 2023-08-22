# frozen_string_literal: true

class Project < ApplicationRecord
  has_ulid

  belongs_to :user
  has_many :deliverables, inverse_of: :project, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :user_id }

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[user deliverables]
  end
end

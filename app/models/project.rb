# frozen_string_literal: true

class Project < ApplicationRecord
  has_ulid
  belongs_to :user
  validates :name, presence: true, uniqueness: { scope: :user_id }

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id name updated_at user_id]
  end
end

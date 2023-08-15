# frozen_string_literal: true

class Project < ApplicationRecord
  has_ulid
  belongs_to :user
  validates :name, presence: true, uniqueness: { scope: :user_id }
end

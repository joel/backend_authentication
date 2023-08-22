# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_ulid

  has_many :projects, dependent: :destroy, inverse_of: :user

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name created_at updated_at]
  end
end

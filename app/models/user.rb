# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_ulid

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
end

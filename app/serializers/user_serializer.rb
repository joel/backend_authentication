# frozen_string_literal: true

class UserSerializer
  include ActiveModel::Serialization

  attr_accessor :name

  def attributes
    { "name" => nil }
  end
end

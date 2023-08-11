# frozen_string_literal: true

class UserSerializer
  include ActiveModel::Serializers::JSON

  attr_accessor :name

  def attributes
    { "name" => nil }
  end
end

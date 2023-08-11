# frozen_string_literal: true

class Current < ActiveSupport::CurrentAttributes
  attribute :user, :api_version
end

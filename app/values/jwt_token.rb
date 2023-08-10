# frozen_string_literal: true

JwtToken = Data.define(:payload, :options) do
  delegate :[], to: :payload
end

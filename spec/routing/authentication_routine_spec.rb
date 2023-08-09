# frozen_string_literal: true

require "rails_helper"

RSpec.describe AuthenticationController do
  describe "routing" do
    it "routes to #create" do
      expect(post: "/login").to route_to("authentication#create")
    end
  end
end

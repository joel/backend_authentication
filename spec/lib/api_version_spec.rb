# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApiVersion do
  let(:default_version) { 1 }
  let(:headers) { { "Content-Type" => "application/json" } }

  it "the default version should be set" do
    expect(ApiVersion::DEFAULT_VERSION).to eql(default_version)
  end

  describe "#matches?" do
    subject { described_class.new(version).matches?(request) }

    let(:request) { instance_double(ActionController::TestRequest, headers:) }
    let(:version) { 1 }

    context "when version is a float" do
      let(:version) { 1.1 }
      let(:headers) { super().merge({ "Accept" => "application/x-api-v#{version}+json" }) }

      it { is_expected.to be_truthy }
    end

    context "with right version" do
      let(:headers) { super().merge({ "Accept" => "application/x-api-v1+json" }) }

      it { is_expected.to be_truthy }
    end

    context "with lesser version" do
      let(:headers) { super().merge({ "Accept" => "application/x-api-v0+json" }) }

      it { is_expected.to be_falsey }
    end

    context "with higher version" do
      let(:headers) { super().merge({ "Accept" => "application/x-api-v2+json" }) }

      it { is_expected.to be_truthy }
    end

    context "without version when quering default version" do
      it { is_expected.to be_truthy }

      context "without version when quering no-default version" do
        subject { described_class.new(non_default_version).matches?(request) }

        let(:non_default_version) { 2 }

        it { is_expected.to be_falsey }
      end
    end
  end
end

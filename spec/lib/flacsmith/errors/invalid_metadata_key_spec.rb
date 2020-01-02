# frozen_string_literal: true

require "spec_helper"

RSpec.describe Flacsmith::Errors::InvalidMetadataKey do
  let(:keys) { Flacsmith::Metadata::Tag::KEYS.join ", " }

  describe "#message" do
    it "answers message with defaults" do
      message = %(Invalid metadata key(s): "". Use: "#{keys}".)
      expect(described_class.new.message).to eq(message)
    end

    it "answers message with nil keys" do
      message = %(Invalid metadata key(s): "". Use: "#{keys}".)
      expect(described_class.new(nil).message).to eq(message)
    end

    it "answers message with invalid keys" do
      error = described_class.new %w[bogus unknown]
      message = %(Invalid metadata key(s): "bogus, unknown". Use: "#{keys}".)

      expect(error.message).to eq(message)
    end
  end
end

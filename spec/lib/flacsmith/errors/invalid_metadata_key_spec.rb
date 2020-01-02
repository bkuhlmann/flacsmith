# frozen_string_literal: true

require "spec_helper"

RSpec.describe Flacsmith::Errors::InvalidMetadataKey do
  describe "#message" do
    it "answers helpful message with invalid and valid keys" do
      error = described_class.new keys: %w[bogus unknown]
      keys = Flacsmith::Metadata::Tag::KEYS.join ", "
      message = %(Invalid metadata key(s): "bogus, unknown". Use: "#{keys}".)

      expect(error.message).to eq(message)
    end
  end
end

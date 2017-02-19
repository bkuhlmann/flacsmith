# frozen_string_literal: true

require "spec_helper"

RSpec.describe Flacsmith::Metadata::Formatter do
  subject { described_class.new text }

  describe "#to_h" do
    context "with single key=value pair" do
      let(:text) { "example=test" }

      it "answers hash with single item" do
        expect(subject.to_h).to eq("example" => "test")
      end
    end

    context "with multiple key=value pairs" do
      let(:text) { "example_1=test_1\nexample_2=test_2" }

      it "answers hash with multiple items" do
        expect(subject.to_h).to eq(
          "example_1" => "test_1",
          "example_2" => "test_2"
        )
      end
    end

    context "with malformed text" do
      let(:text) { "bogus" }

      it "answers hash with nil value" do
        expect(subject.to_h).to eq("bogus" => nil)
      end
    end

    context "with nil" do
      let(:text) { nil }

      it "answers empty hash" do
        expect(subject.to_h).to eq({})
      end
    end

    context "with empty text" do
      let(:text) { "" }

      it "answers empty hash" do
        expect(subject.to_h).to eq({})
      end
    end
  end
end

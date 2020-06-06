# frozen_string_literal: true

require "spec_helper"

RSpec.describe Flacsmith::Metadata::Tag do
  describe ".defaults" do
    it "answers default keys" do
      expect(described_class.defaults.map(&:key)).to contain_exactly(*described_class::KEYS)
    end

    it "answers empty values" do
      proof = Array.new(described_class::KEYS.size) { "" }
      expect(described_class.defaults.map(&:value)).to contain_exactly(*proof)
    end
  end

  describe ".for" do
    it "creates new tag for key" do
      expect(described_class.for("VERSION")).to be_a(described_class)
    end

    it "creates new tag for key and value" do
      expect(described_class.for("VERSION", "1.0.0")).to be_a(described_class)
    end
  end

  describe "#initialize" do
    it "fails with error when given an invalid key" do
      result = -> { described_class.new "bogus" }
      message = /Invalid\smetadata\skey.+"bogus".+/

      expect(&result).to raise_error(Flacsmith::Errors::InvalidMetadataKey, message)
    end
  end

  describe "#value" do
    it "defaults to an empty string" do
      tag = described_class.new "ARTIST"
      expect(tag.value).to eq("")
    end

    it "is escaped for use on the command line" do
      tag = described_class.new "ALBUM", %(O'ver the "Hills")
      expect(tag.value).to eq("O\\'ver\\ the\\ \\\"Hills\\\"")
    end
  end

  shared_examples_for "a string" do |method|
    context "with key and value" do
      subject(:tag) { described_class.new "ARTIST", "Santana" }

      it "answers key and value string" do
        expect(tag.public_send(method)).to eq("ARTIST=Santana")
      end
    end

    context "with key" do
      subject(:tag) { described_class.new "ARTIST" }

      it "answers key and empty value string" do
        expect(tag.public_send(method)).to eq("ARTIST=")
      end
    end
  end

  describe "#to_s" do
    it_behaves_like "a string", :to_s
  end

  describe "#to_str" do
    it_behaves_like "a string", :to_str
  end
end

# frozen_string_literal: true

require "spec_helper"

RSpec.describe Flacsmith::Metadata::Image do
  let(:path) { File.join Bundler.root, "spec", "support", "files", "sample.jpg" }
  subject { described_class.new path }

  describe "#dimensions" do
    it "answers empty string" do
      expect(subject.dimensions).to eq("")
    end
  end

  describe "#exist?" do
    context "when picture exists" do
      it "answers true" do
        expect(subject.exist?).to eq(true)
      end
    end

    context "when picture doesn't exist" do
      let(:path) { "" }

      it "answers false" do
        expect(subject.exist?).to eq(false)
      end
    end
  end

  shared_examples_for "a string" do |method|
    context "with default type and description" do
      it "answers default picture metadata" do
        expect(subject.public_send(method)).to eq("3|image/jpeg|Cover||#{path}")
      end
    end

    context "with custom type and description" do
      subject { described_class.new path, type: 5, description: "Example" }

      it "answers custom picture metadata" do
        expect(subject.public_send(method)).to eq("5|image/jpeg|Example||#{path}")
      end
    end

    context "with missing type" do
      subject { described_class.new path, type: nil }

      it "answers picture metadata without type" do
        expect(subject.public_send(method)).to eq("|image/jpeg|Cover||#{path}")
      end
    end

    context "with missing description" do
      subject { described_class.new path, description: nil }

      it "answers picture metadata without type" do
        expect(subject.public_send(method)).to eq("3|image/jpeg|||#{path}")
      end
    end

    context "without existing path" do
      let(:path) { "" }

      it "answers empty string" do
        expect(subject.public_send(method)).to eq("")
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

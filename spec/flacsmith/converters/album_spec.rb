# frozen_string_literal: true

require "spec_helper"

RSpec.describe Flacsmith::Converters::Album, :temp_dir do
  let(:input_dir) { File.join Bundler.root, "spec", "support", "files" }
  let(:image_path) { File.join Bundler.root, "spec", "support", "files", "sample.jpg" }
  let(:output_dir) { temp_dir }
  subject do
    described_class.new input_dir: input_dir, output_dir: output_dir, image_path: image_path
  end

  describe "#convert" do
    it "converts input files to FLAC files" do
      subject.convert

      expect(Pathname(temp_dir).entries).to contain_exactly(
        Pathname("."),
        Pathname(".."),
        Pathname("sample.flac")
      )
    end
  end
end

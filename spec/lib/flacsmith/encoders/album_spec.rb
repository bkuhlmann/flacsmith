# frozen_string_literal: true

require "spec_helper"

RSpec.describe Flacsmith::Encoders::Album do
  subject :album do
    described_class.new input_dir: input_dir, output_dir: output_dir, image_path: image_path
  end

  include_context "with temporary directory"

  let(:input_dir) { File.join Bundler.root, "spec", "support", "files" }
  let(:image_path) { File.join Bundler.root, "spec", "support", "files", "sample.jpg" }
  let(:output_dir) { temp_dir }

  describe "#encode" do
    it "encodes input files as FLAC files" do
      album.encode

      expect(Pathname(temp_dir).entries).to contain_exactly(
        Pathname("."),
        Pathname(".."),
        Pathname("sample.flac")
      )
    end
  end
end

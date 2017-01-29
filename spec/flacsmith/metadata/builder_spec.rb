# frozen_string_literal: true

require "spec_helper"

RSpec.describe Flacsmith::Metadata::Builder, :temp_dir do
  let(:sample_file) { Pathname.new "#{Dir.pwd}/spec/support/files/sample.flac" }
  let(:album_path) { Pathname.new "#{temp_dir}/Test Artist/Test Album" }
  subject { described_class.new temp_dir }

  before do
    FileUtils.mkdir_p album_path

    (1..5).each do |number|
      FileUtils.cp sample_file, Pathname.new("#{album_path}/0#{number} Test Title.flac")
    end
  end

  describe "#paths" do
    let(:proof_paths) { Pathname.glob "#{album_path}**/*" }

    context "when paths exist" do
      it "answers array of FLAC paths" do
        expect(subject.paths).to eq(proof_paths)
      end
    end

    context "when paths don't exist" do
      before { FileUtils.rm_rf album_path }

      it "answers empty array" do
        expect(subject.paths).to eq([])
      end
    end

    context "when path has trailing slash" do
      subject { described_class.new "#{temp_dir}/" }

      it "answers array of FLAC paths" do
        expect(subject.paths).to eq(proof_paths)
      end
    end
  end

  describe "#build" do
    it "updates track metadata", :aggregate_failures do
      subject.build

      Dir["#{album_path}**/*"].sort.each.with_index do |path, index|
        file = Flacsmith::Metadata::File.new path
        number = (index + 1).to_s.rjust 2, "0"

        expect(file.artist).to eq("Test Artist")
        expect(file.album).to eq("Test Album")
        expect(file.number).to eq(number)
        expect(file.title).to eq("Test Title")
      end
    end
  end
end

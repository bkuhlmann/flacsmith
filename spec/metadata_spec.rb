require "spec_helper"

RSpec.describe Flacsmith::Metadata, :temp_dir do
  let(:sample_file_path) { File.join Dir.pwd, "spec", "support", "files", "sample.flac" }
  let(:album_path) { File.join temp_dir, "Test Artist", "Test Album" }

  subject { Flacsmith::Metadata.new temp_dir }

  before do
    FileUtils.mkdir_p album_path

    (1..5).each do |number|
      FileUtils.cp sample_file_path, File.join(album_path, "0#{number} Test Title.flac")
    end
  end

  describe "#files" do
    it "answers FLAC files" do
      titles = subject.files.map(&:path).sort
      results = (1..5).map { |number| File.join album_path, "0#{number} Test Title.flac" }

      expect(titles).to eq(results)
    end

    it "answers a single FLAC file" do
      subject = Flacsmith::Metadata.new File.join(album_path, "01 Test Title.flac")
      files = subject.files.map(&:path)
      result = [File.join(album_path, "01 Test Title.flac")]

      expect(files).to eq(result)
    end

    it "answers an empty array when no FLAC files exist" do
      subject.path = "bogus_path"
      expect(subject.files).to eq([])
    end
  end

  describe "#rebuild" do
    it "updates track metadata based on artist, album, track number, and track title" do
      subject.rebuild

      Dir["#{album_path}**/*"].sort.each.with_index do |file, index|
        flac_file = Flacsmith::Flacfile.new file
        track_number = (index + 1).to_s.rjust 2, "0"

        expect(flac_file.artist).to eq("Test Artist")
        expect(flac_file.album).to eq("Test Album")
        expect(flac_file.tracknumber).to eq(track_number)
        expect(flac_file.title).to eq("Test Title")
      end
    end

    it "yields for a block" do
      flac_files = []
      subject.rebuild { |file| flac_files << file }
      results = Dir["#{album_path}**/*"].map { |file| Flacsmith::Flacfile.new file }

      expect(results).to eq(results)
    end

    it "answers an empty array when no FLAC files exist" do
      subject.path = "bogus_path"
      expect(subject.rebuild).to eq([])
    end
  end
end

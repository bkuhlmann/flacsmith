# frozen_string_literal: true

require "spec_helper"

RSpec.describe Flacsmith::Metadata::File, :temp_dir do
  let(:path) { "/Artist/Album/Track.flac" }
  subject { described_class.new path }

  describe "#artist" do
    context "with artist and album directories" do
      it "answers album" do
        expect(subject.artist).to eq("Artist")
      end
    end

    context "with album directory only" do
      let(:path) { "/Album/Track.flac" }

      it "answers empty string" do
        expect(subject.artist).to eq("")
      end
    end

    context "without directories" do
      let(:path) { "Track.flac" }

      it "answers empty string" do
        expect(subject.artist).to eq("")
      end
    end

    context "with empty path" do
      let(:path) { "" }

      it "answers empty string" do
        expect(subject.artist).to eq("")
      end
    end
  end

  describe "#album" do
    context "with album directory" do
      it "answers album" do
        expect(subject.album).to eq("Album")
      end
    end

    context "without directories" do
      let(:path) { "Track.flac" }

      it "answers empty string" do
        expect(subject.album).to eq("")
      end
    end

    context "with empty path" do
      let(:path) { "" }

      it "answers empty string" do
        expect(subject.album).to eq("")
      end
    end
  end

  describe "#number" do
    context "with single digit number" do
      let(:path) { "1 Track.flac" }

      it "answers zero padded number" do
        expect(subject.number).to eq "01"
      end
    end

    context "with double digit number" do
      let(:path) { "12 Track.flac" }

      it "answers double digit number" do
        expect(subject.number).to eq "12"
      end
    end

    context "with track number and number in title" do
      let(:path) { "5 18 and Life.flac" }

      it "answers track number only" do
        expect(subject.number).to eq("05")
      end
    end

    context "without number" do
      let(:path) { "Track.flac" }

      it "answers double zeros" do
        expect(subject.number).to eq ""
      end
    end

    context "with full path" do
      let(:path) { "/Some/Path/To/Artist/and/Album/2 Paranoid.flac" }

      it "answers track number only" do
        expect(subject.number).to eq("02")
      end
    end

    context "with empty path" do
      let(:path) { "" }

      it "answers empty string" do
        expect(subject.number).to eq("")
      end
    end
  end

  describe "title" do
    context "with parent directories" do
      it "answers title" do
        expect(subject.title).to eq "Track"
      end
    end

    context "without parent directories" do
      let(:path) { "Track.flac" }

      it "answers title" do
        expect(subject.title).to eq "Track"
      end
    end

    context "with numbered file" do
      let(:path) { "01 Track.flac" }

      it "answers title" do
        expect(subject.title).to eq "Track"
      end
    end

    context "with numbered file without spaces" do
      let(:path) { "01Track.flac" }

      it "answers title" do
        expect(subject.title).to eq "Track"
      end
    end

    context "with numbered file and title" do
      let(:path) { "5 18 and Life.flac" }

      it "answers title" do
        expect(subject.title).to eq("18 and Life")
      end
    end

    context "with unknown file extension" do
      let(:path) { "Test.test" }

      it "answers title" do
        expect(subject.title).to eq("Test")
      end
    end

    context "with empty path" do
      let(:path) { "" }

      it "answers empty string" do
        expect(subject.title).to eq("")
      end
    end
  end

  describe "#name" do
    context "with number and title" do
      let(:path) { "100 Track.flac" }

      it "answers track name as number and title" do
        expect(subject.name).to eq("100 Track")
      end
    end

    context "with number" do
      let(:path) { "100.flac" }

      it "answers track name as number only" do
        expect(subject.name).to eq("100")
      end
    end

    context "with title" do
      let(:path) { "Track.flac" }

      it "answers track name as title only" do
        expect(subject.name).to eq("Track")
      end
    end

    context "with no number and title" do
      let(:path) { "" }

      it "answers track name as empty string" do
        expect(subject.name).to eq("")
      end
    end
  end

  describe "#tags" do
    it "answers metadata tags" do
      tags = subject.tags.reduce({}) { |new_hash, tag| new_hash.merge tag.key => tag.value }

      expect(tags).to eq(
        "TRACKNUMBER" => "",
        "TITLE" => "Track",
        "ALBUM" => "Album",
        "ARTIST" => "Artist"
      )
    end
  end

  describe "#to_s" do
    it "answers string path" do
      expect(subject.to_s).to eq(path)
    end
  end

  describe "#to_str" do
    it "answers string path" do
      expect(subject.to_str).to eq(path)
    end
  end

  describe "#to_h" do
    it "answers metadata hash" do
      expect(subject.to_h).to eq(
        "TRACKNUMBER" => "",
        "TITLE" => "Track",
        "ALBUM" => "Album",
        "ARTIST" => "Artist"
      )
    end
  end

  describe "#to_hash" do
    it "answers metadata hash" do
      expect(subject.to_hash).to eq(
        "TRACKNUMBER" => "",
        "TITLE" => "Track",
        "ALBUM" => "Album",
        "ARTIST" => "Artist"
      )
    end
  end
end

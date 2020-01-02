# frozen_string_literal: true

require "spec_helper"

RSpec.describe Flacsmith::Metadata::Tagger, :temp_dir do
  subject(:tagger) { described_class.new test_file }

  let(:album_path) { Pathname.new "#{temp_dir}/Test Artist/Test Album" }
  let(:sample_file) { Pathname.new "#{Dir.pwd}/spec/support/files/sample.flac" }
  let(:test_file) { Pathname.new "#{album_path}/01 Test Title.flac" }

  let :default_hash do
    {
      "ALBUM" => "Flacsmith Album",
      "ARTIST" => "Flacsmith Artist",
      "CONTACT" => "Flacsmith Contact",
      "COPYRIGHT" => "2014",
      "DATE" => "2014-01-01",
      "DESCRIPTION" => "Flacsmith Description",
      "GENRE" => "Flacsmith Genre",
      "ISRC" => "FS-F22-14-00002",
      "LICENSE" => "MIT",
      "LOCATION" => "Flacsmith Location",
      "ORGANIZATION" => "Flacsmith Organization",
      "PERFORMER" => "Flacsmith Performer",
      "TITLE" => "Flacsmith Title",
      "TRACKNUMBER" => "02",
      "VERSION" => "1.0.0"
    }
  end

  let :default_tags do
    default_hash.map { |key, value| Flacsmith::Metadata::Tag.for key, value }
  end

  before do
    FileUtils.mkdir_p album_path
    FileUtils.cp sample_file, test_file
  end

  describe "#read" do
    context "with default tags" do
      it "answers default tag hash" do
        expect(tagger.read).to eq(default_hash)
      end
    end

    context "with custom tag" do
      let(:tag) { Flacsmith::Metadata::Tag.for "VERSION" }

      it "answers single tag hash" do
        expect(tagger.read(tag)).to eq("VERSION" => "1.0.0")
      end
    end

    context "with custom tags" do
      let :tags do
        [
          Flacsmith::Metadata::Tag.for("COPYRIGHT"),
          Flacsmith::Metadata::Tag.for("LICENSE")
        ]
      end

      it "answers multiple tag hash" do
        expect(tagger.read(tags)).to eq(
          "COPYRIGHT" => "2014",
          "LICENSE" => "MIT"
        )
      end
    end

    context "with nil tags" do
      it "answers empty hash" do
        expect(tagger.read(nil)).to eq({})
      end
    end

    context "with empty tags" do
      it "answers empty hash" do
        expect(tagger.read([])).to eq({})
      end
    end
  end

  describe "#add" do
    context "with default tags" do
      it "answers empty hash", :aggregate_failures do
        expect(tagger.add).to eq({})
        expect(tagger.read).to eq(default_hash)
      end
    end

    context "with custom tag" do
      let(:tags) { Flacsmith::Metadata::Tag.for "ARTIST", "Test" }

      it "answers single tag hash", :aggregate_failures do
        expect(tagger.add(tags)).to eq({})
        expect(tagger.read(tags)).to eq("ARTIST" => "Test")
      end
    end

    context "with custom tags" do
      let :tags do
        [
          Flacsmith::Metadata::Tag.for("ARTIST", "Test"),
          Flacsmith::Metadata::Tag.for("ALBUM", "The Album")
        ]
      end

      it "answers multiple tag hash", :aggregate_failures do
        expect(tagger.add(tags)).to eq({})
        expect(tagger.read(tags)).to eq(
          "ARTIST" => "Test",
          "ALBUM" => "The Album"
        )
      end
    end

    context "with nil tags" do
      let(:tags) { nil }

      it "answers empty hash", :aggregate_failures do
        expect(tagger.add(tags)).to eq({})
        expect(tagger.read(tags)).to eq({})
      end
    end

    context "with empty tags" do
      let(:tags) { [] }

      it "answers empty hash", :aggregate_failures do
        expect(tagger.add(tags)).to eq({})
        expect(tagger.read(tags)).to eq({})
      end
    end
  end

  describe "#remove" do
    context "with default tags" do
      it "answers empty hash", :aggregate_failures do
        expect(tagger.remove).to eq({})
        expect(tagger.read).to eq(default_hash)
      end
    end

    context "with custom tag" do
      let(:tags) { Flacsmith::Metadata::Tag.for "ALBUM" }

      it "answers empty hash", :aggregate_failures do
        expect(tagger.remove(tags)).to eq({})
        expect(tagger.read(tags)).to eq({})
      end
    end

    context "with custom tags" do
      let :tags do
        [
          Flacsmith::Metadata::Tag.for("ARTIST"),
          Flacsmith::Metadata::Tag.for("ALBUM")
        ]
      end

      it "answers empty hash", :aggregate_failures do
        expect(tagger.remove(tags)).to eq({})
        expect(tagger.read(tags)).to eq({})
      end
    end

    context "with nil tags" do
      let(:tags) { nil }

      it "answers empty hash", :aggregate_failures do
        expect(tagger.remove(tags)).to eq({})
        expect(tagger.read(tags)).to eq({})
      end
    end

    context "with empty tags" do
      let(:tags) { [] }

      it "answers empty hash", :aggregate_failures do
        expect(tagger.remove(tags)).to eq({})
        expect(tagger.read(tags)).to eq({})
      end
    end
  end

  describe "#update" do
    context "with default tags" do
      it "answers empty tags", :aggregate_failures do
        expect(tagger.update).to eq({})
        expect(tagger.read).to eq(default_hash)
      end
    end

    context "with custom tags" do
      let :tags do
        [
          Flacsmith::Metadata::Tag.for("ARTIST", "Test"),
          Flacsmith::Metadata::Tag.for("ALBUM", "The Album")
        ]
      end

      it "answers multiple tag hash", :aggregate_failures do
        expect(tagger.update(tags)).to eq({})
        expect(tagger.read(tags)).to eq(
          "ARTIST" => "Test",
          "ALBUM" => "The Album"
        )
      end
    end

    context "with nil tags" do
      let(:tags) { nil }

      it "answers empty hash", :aggregate_failures do
        expect(tagger.update(tags)).to eq({})
        expect(tagger.read(tags)).to eq({})
      end
    end

    context "with empty tags" do
      let(:tags) { [] }

      it "answers empty hash", :aggregate_failures do
        expect(tagger.update(tags)).to eq({})
        expect(tagger.read(tags)).to eq({})
      end
    end
  end
end

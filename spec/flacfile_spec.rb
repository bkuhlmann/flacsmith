require "spec_helper"

describe Flacsmith::Flacfile, :temp_dir do
  let(:sample_file_path) { File.join Dir.pwd, "spec", "support", "files", "sample.flac" }
  let(:test_file_path) { File.join temp_dir, "test.flac" }
  subject { Flacsmith::Flacfile.new test_file_path }
  before { FileUtils.cp sample_file_path, test_file_path }

  describe ".parse_number" do
    it "answers file number" do
      expect(Flacsmith::Flacfile.parse_number("02 Red Barchetta.flac")).to eq "02"
    end

    it "answers file number even when title includes number" do
      expect(Flacsmith::Flacfile.parse_number("05 18 and Life.flac")).to eq "05"
    end
  end

  describe ".parse_title" do
    it "answers file title" do
      expect(Flacsmith::Flacfile.parse_title("02 Red Barchetta.flac")).to eq "Red Barchetta"
    end

    it "answers file title even when title includes number" do
      expect(Flacsmith::Flacfile.parse_title("05 18 and Life.flac")).to eq "18 and Life"
    end
  end

  describe "#initialize" do
    it "initializes file path" do
      expect(subject.path).to eq(test_file_path)
    end
  end

  describe "#get_tag" do
    it "answers an empty string for invalid file" do
      subject.path = "/bogus/file.flac"
      expect(subject.get_tag("ARTIST")).to eq('')
    end

    it "answers an empty string when no tag can be found" do
      expect(subject.get_tag("BOGUS")).to eq('')
    end
  end

  describe "#get_tags" do
    it "answers tags (hash) for a given array of keys" do
      keys = %w(ARTIST ALBUM TITLE)
      result = {
        "ARTIST" => "Flacsmith Artist",
        "ALBUM" => "Flacsmith Album",
        "TITLE" => "Flacsmith Title"
      }

      expect(subject.get_tags(keys)).to eq(result)
    end

    it "answers all known tags (hash) for an empty array of keys" do
      result = {
        "ARTIST" => "Flacsmith Artist",
        "PERFORMER" => "Flacsmith Performer",
        "ALBUM" => "Flacsmith Album",
        "GENRE" => "Flacsmith Genre",
        "ORGANIZATION" => "Flacsmith Organization",
        "TRACKNUMBER" => "02",
        "TITLE" => "Flacsmith Title",
        "DESCRIPTION" => "Flacsmith Description",
        "LOCATION" => "Flacsmith Location",
        "CONTACT" => "Flacsmith Contact",
        "LICENSE" => "MIT",
        "VERSION" => "1.0.0",
        "COPYRIGHT" => "2014",
        "DATE" => "2014-01-01",
        "ISRC" => "FS-F22-14-00002"
      }

      expect(subject.get_tags).to eq(result)
    end

    it "answers blank values when key doesn't exist" do
      subject.remove_tag "TITLE"

      result = {
        "ARTIST" => "Flacsmith Artist",
        "PERFORMER" => "Flacsmith Performer",
        "ALBUM" => "Flacsmith Album",
        "GENRE" => "Flacsmith Genre",
        "ORGANIZATION" => "Flacsmith Organization",
        "TRACKNUMBER" => "02",
        "TITLE" => '',
        "DESCRIPTION" => "Flacsmith Description",
        "LOCATION" => "Flacsmith Location",
        "CONTACT" => "Flacsmith Contact",
        "LICENSE" => "MIT",
        "VERSION" => "1.0.0",
        "COPYRIGHT" => "2014",
        "DATE" => "2014-01-01",
        "ISRC" => "FS-F22-14-00002"
      }

      expect(subject.get_tags).to eq(result)
    end
  end

  describe "#remove_tag" do
    it "removes tag for given key" do
      subject.remove_tag "TITLE"
      expect(subject.title).to eq('')
    end

    it "answers an empty string when no tag can be found" do
      expect(subject.remove_tag("BOGUS")).to eq('')
    end
  end

  describe "#set_tag" do
    it "answers an empty string for invalid file" do
      subject.path = "/bogus/file.flac"
      expect(subject.set_tag("ARTIST", "Test Artist")).to eq('')
    end

    it "answers an empty string when no tag can be found" do
      expect(subject.set_tag("BOGUS", "Bogus")).to eq('')
    end
  end

  describe "#set_tags" do
    it "sets multiple tags for given hash" do
      tags = {
        "ARTIST" => "MultiTag Artist",
        "ALBUM" => "MultiTag Album",
        "TITLE" => "MultiTag Title"
      }
      subject.set_tags tags

      expect(subject.artist).to eq("MultiTag Artist")
      expect(subject.album).to eq("MultiTag Album")
      expect(subject.title).to eq("MultiTag Title")
    end
  end

  describe "#artist" do
    it "gets the artist tag" do
      expect(subject.artist).to eq("Flacsmith Artist")
    end
  end

  describe "#artist=" do
    it "sets the artist tag" do
      subject.artist = "Test Artist"
      expect(subject.artist).to eq("Test Artist")
    end
  end

  describe "#performer" do
    it "gets the performer tag" do
      expect(subject.performer).to eq('Flacsmith Performer')
    end
  end

  describe "#performer=" do
    it "sets the performer tag" do
      subject.performer = "Test Performer"
      expect(subject.performer).to eq("Test Performer")
    end
  end

  describe "#album" do
    it "gets the album tag" do
      expect(subject.album).to eq("Flacsmith Album")
    end
  end

  describe "#album=" do
    it "sets the album tag" do
      subject.album = "Test Album"
      expect(subject.album).to eq("Test Album")
    end
  end

  describe "#genre" do
    it "gets the genre tag" do
      expect(subject.genre).to eq("Flacsmith Genre")
    end
  end

  describe "#genre=" do
    it "sets the genre tag" do
      subject.genre = "Test Genre"
      expect(subject.genre).to eq("Test Genre")
    end
  end

  describe "#organization" do
    it "gets the organization tag" do
      expect(subject.organization).to eq("Flacsmith Organization")
    end
  end

  describe "#organization=" do
    it "sets the organization tag" do
      subject.organization = "Test Organization"
      expect(subject.organization).to eq("Test Organization")
    end
  end

  describe "#tracknumber" do
    it "gets the tracknumber tag" do
      expect(subject.tracknumber).to eq("02")
    end
  end

  describe "#tracknumber=" do
    it "sets the tracknumber tag" do
      subject.tracknumber = "05"
      expect(subject.tracknumber).to eq("05")
    end
  end

  describe "#title" do
    it "gets the title tag" do
      expect(subject.title).to eq("Flacsmith Title")
    end
  end

  describe "#title=" do
    it "sets the title tag" do
      subject.title = "Test Title"
      expect(subject.title).to eq("Test Title")
    end
  end

  describe "#description" do
    it "gets the description tag" do
      expect(subject.description).to eq("Flacsmith Description")
    end
  end

  describe "#description=" do
    it "sets the description tag" do
      subject.description = "Test Description"
      expect(subject.description).to eq("Test Description")
    end
  end

  describe "#location" do
    it "gets the location tag" do
      expect(subject.location).to eq("Flacsmith Location")
    end
  end

  describe "#location=" do
    it "sets the location tag" do
      subject.location = "Test Location"
      expect(subject.location).to eq("Test Location")
    end
  end

  describe "#contact" do
    it "gets the contact tag" do
      expect(subject.contact).to eq("Flacsmith Contact")
    end
  end

  describe "#contact=" do
    it "sets the contact tag" do
      subject.contact = "Test Contact"
      expect(subject.contact).to eq("Test Contact")
    end
  end

  describe "#license" do
    it "gets the license tag" do
      expect(subject.license).to eq("MIT")
    end
  end

  describe "#license=" do
    it "sets the license tag" do
      subject.license = "GPL"
      expect(subject.license).to eq("GPL")
    end
  end

  describe "#version" do
    it "gets the version tag" do
      expect(subject.version).to eq("1.0.0")
    end
  end

  describe "#version=" do
    it "sets the version tag" do
      subject.version = "2.0.0"
      expect(subject.version).to eq("2.0.0")
    end
  end

  describe "#copyright" do
    it "gets the copyright tag" do
      expect(subject.copyright).to eq("2014")
    end
  end

  describe "#copyright=" do
    it "sets the copyright tag" do
      subject.copyright = "2112"
      expect(subject.copyright).to eq("2112")
    end
  end

  describe "#date" do
    it "gets the date tag" do
      expect(subject.date).to eq("2014-01-01")
    end
  end

  describe "#date=" do
    it "sets the date tag" do
      subject.date = "2014-03-15"
      expect(subject.date).to eq("2014-03-15")
    end
  end

  describe "#isrc" do
    it "gets the isrc tag" do
      expect(subject.isrc).to eq("FS-F22-14-00002")
    end
  end

  describe "#isrc=" do
    it "sets the isrc tag" do
      subject.isrc = "TT-T01-01-10000"
      expect(subject.isrc).to eq("TT-T01-01-10000")
    end
  end
end

# frozen_string_literal: true

require "spec_helper"

RSpec.describe Flacsmith::Encoders::Track, :temp_dir do
  let(:input_path) { File.join Bundler.root, "spec", "support", "files", "sample.aiff" }
  let(:image_path) { File.join Bundler.root, "spec", "support", "files", "sample.jpg" }
  let(:output_dir) { temp_dir }
  let(:buffer) { StringIO.new }
  let(:logger) { Logger.new buffer }

  subject do
    described_class.new input_path: input_path,
                        image_path: image_path,
                        output_dir: output_dir,
                        logger: logger
  end

  describe "#encode" do
    let(:flac_file) { File.join temp_dir, "sample.flac" }

    context "with valid input" do
      it "encodes input file to FLAC file" do
        subject.encode
        expect(File.exist?(flac_file)).to eq(true)
      end

      it "logs empty message to standard output" do
        subject.encode
        expect(buffer.string).to match(/.+INFO\s\-\-\s\:\s\n/)
      end

      it "answers true" do
        expect(subject.encode).to eq(true)
      end
    end

    context "with special characters in input file name" do
      let(:special_path) { File.join temp_dir, %("a rockin' special".aiff) }
      let(:flac_file) { File.join temp_dir, %("a rockin' special".flac) }
      before { FileUtils.cp input_path, special_path }

      subject do
        described_class.new input_path: special_path,
                            image_path: image_path,
                            output_dir: output_dir,
                            logger: logger
      end

      it "escapes and encodes to FLAC file format" do
        subject.encode
        expect(File.exist?(flac_file)).to eq(true)
      end

      it "logs empty message to standard output" do
        subject.encode
        expect(buffer.string).to match(/.+INFO\s\-\-\s\:\s\n/)
      end

      it "answers true" do
        expect(subject.encode).to eq(true)
      end
    end

    context "with special characters in image file name" do
      let(:special_path) { File.join temp_dir, %("test image".jpg) }
      before { FileUtils.cp image_path, special_path }

      subject do
        described_class.new input_path: input_path,
                            image_path: special_path,
                            output_dir: output_dir,
                            logger: logger
      end

      it "escapes and encodes to FLAC file format" do
        subject.encode
        expect(File.exist?(flac_file)).to eq(true)
      end

      it "logs empty message to standard output" do
        subject.encode
        expect(buffer.string).to match(/.+INFO\s\-\-\s\:\s\n/)
      end

      it "answers true" do
        expect(subject.encode).to eq(true)
      end
    end

    context "with invalid input" do
      let(:input_path) { File.join temp_dir, "sample.aiff" }
      before { FileUtils.touch input_path }

      it "does not encode FLAC file" do
        result = -> { subject.encode }

        expect(&result).to raise_error(Flacsmith::Errors::Track) do
          expect(File.exist?(flac_file)).to eq(false)
        end
      end

      it "fails with track error" do
        result = -> { subject.encode }
        regex = /.*ERROR\:.+you\smust\sspecify\sa\svalue.*/

        expect(&result).to raise_error(Flacsmith::Errors::Track, regex)
      end
    end

    context "with missing picture" do
      let(:image_path) { nil }

      it "encodes input file to FLAC file" do
        subject.encode
        expect(File.exist?(flac_file)).to eq(true)
      end

      it "logs empty message to standard output" do
        subject.encode
        expect(buffer.string).to match(/.+INFO\s\-\-\s\:\s\n/)
      end

      it "answers true" do
        expect(subject.encode).to eq(true)
      end
    end
  end
end

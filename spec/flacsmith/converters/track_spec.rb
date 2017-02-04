# frozen_string_literal: true

require "spec_helper"

RSpec.describe Flacsmith::Converters::Track, :temp_dir do
  let(:input_path) { File.join Bundler.root, "spec", "support", "files", "sample.aiff" }
  let(:picture_path) { File.join Bundler.root, "spec", "support", "files", "sample.jpg" }
  let(:output_dir) { temp_dir }
  let(:buffer) { StringIO.new }
  let(:logger) { Logger.new buffer }

  subject do
    described_class.new input_path: input_path,
                        picture_path: picture_path,
                        output_dir: output_dir,
                        logger: logger
  end

  describe "#convert" do
    let(:flac_file) { File.join temp_dir, "sample.flac" }

    context "with valid input" do
      it "converts input file to FLAC file" do
        subject.convert
        expect(File.exist?(flac_file)).to eq(true)
      end

      it "logs empty message for standard output" do
        subject.convert
        expect(buffer.string).to match(/.+INFO\s\-\-\s\:\s\n/)
      end

      it "answers true" do
        expect(subject.convert).to eq(true)
      end
    end

    context "with special characters in input file name" do
      let(:special_path) { File.join temp_dir, %("a rockin' special".aiff) }
      let(:flac_file) { File.join temp_dir, %("a rockin' special".flac) }
      before { FileUtils.cp input_path, special_path }

      subject do
        described_class.new input_path: special_path,
                            picture_path: picture_path,
                            output_dir: output_dir,
                            logger: logger
      end

      it "escapes and converts FLAC file format" do
        subject.convert
        expect(File.exist?(flac_file)).to eq(true)
      end

      it "logs empty message for standard output" do
        subject.convert
        expect(buffer.string).to match(/.+INFO\s\-\-\s\:\s\n/)
      end

      it "answers true" do
        expect(subject.convert).to eq(true)
      end
    end

    context "with special characters in picture file name" do
      let(:special_path) { File.join temp_dir, %("test picture".jpg) }
      before { FileUtils.cp picture_path, special_path }

      subject do
        described_class.new input_path: input_path,
                            picture_path: special_path,
                            output_dir: output_dir,
                            logger: logger
      end

      it "escapes and converts FLAC file format" do
        subject.convert
        expect(File.exist?(flac_file)).to eq(true)
      end

      it "logs empty message for standard output" do
        subject.convert
        expect(buffer.string).to match(/.+INFO\s\-\-\s\:\s\n/)
      end

      it "answers true" do
        expect(subject.convert).to eq(true)
      end
    end

    context "with invalid input" do
      let(:input_path) { File.join temp_dir, "sample.aiff" }
      before { FileUtils.touch input_path }

      it "does not generate FLAC file" do
        begin
          subject.convert
        rescue Flacsmith::Errors::Track
          expect(File.exist?(flac_file)).to eq(false)
        end
      end

      it "fails with track error" do
        result = -> { subject.convert }
        regex = /.*ERROR\:.+you\smust\sspecify\sa\svalue.*/

        expect(&result).to raise_error(Flacsmith::Errors::Track, regex)
      end
    end

    context "with missing picture" do
      let(:picture_path) { nil }

      it "converts input file to FLAC file" do
        subject.convert
        expect(File.exist?(flac_file)).to eq(true)
      end

      it "logs empty message for standard output" do
        subject.convert
        expect(buffer.string).to match(/.+INFO\s\-\-\s\:\s\n/)
      end

      it "answers true" do
        expect(subject.convert).to eq(true)
      end
    end
  end
end
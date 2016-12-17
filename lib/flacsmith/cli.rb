# frozen_string_literal: true

require "thor"
require "thor/actions"
require "thor_plus/actions"
require "pathname"

module Flacsmith
  # The Command Line Interface (CLI) for the gem.
  class CLI < Thor
    include Thor::Actions
    include ThorPlus::Actions

    package_name Identity.version_label

    # Initialize.
    def initialize args = [], options = {}, config = {}
      super args, options, config
    end

    desc "-C, [--convert=INPUT_DIR OUTPUT_DIR]", "Convert source audio to FLAC audio."
    map %w[-C --convert] => :convert
    method_option :picture,
                  aliases: "-p",
                  desc: "File path to cover art.",
                  type: :string, default: ""
    def convert input_dir, output_dir
      say "Converting audio: #{input_dir} -> #{output_dir}...\n\n"
      converter = Converters::Album.new input_dir: input_dir,
                                        output_dir: output_dir,
                                        picture_path: options.picture
      converter.convert
      say "Audio converted."
    end

    desc "-l, [--list=PATH]", "List track metadata for given folder/file structure."
    map %w[-l --list] => :list
    def list path
      say "Listing metadata for: #{path}...\n\n"
      print_metadata path
      say "Metadata list complete."
    end

    desc "-r, [--rebuild=PATH]", "Rebuild track metadata for given folder/file structure."
    map %w[-r --rebuild] => :rebuild
    # :reek:TooManyStatements
    def rebuild path
      say "Rebuilding metadata for: #{path}..."

      metadata = Metadata::Builder.new path
      metadata.build
      metadata.paths.each { |file_path| say "Processed: #{file_path}" }

      say "Metadata rebuilt."
    end

    desc "-v, [--version]", "Show gem version."
    map %w[-v --version] => :version
    def version
      say Identity.version_label
    end

    desc "-h, [--help=COMMAND]", "Show this message or get help for a command."
    map %w[-h --help] => :help
    def help task = nil
      say and super
    end

    private

    def print_tags path
      Metadata::Tagger.new(path).read.map { |key, value| say "#{key} = #{value}" }
    end

    def print_metadata path
      Pathname.glob("#{path}/**/*.flac").each do |file_path|
        say "FILE = #{file_path}"
        print_tags file_path
        say
      end
    end
  end
end

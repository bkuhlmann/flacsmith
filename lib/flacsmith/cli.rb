# frozen_string_literal: true

require "thor"
require "thor/actions"
require "thor_plus/actions"

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

    desc "-l, [--list=PATH]", "List track metadata for given folder/file structure."
    map %w[-l --list] => :list
    # :reek:TooManyStatements
    def list path
      say "Listing metadata for: #{path}...\n\n"

      metadata = Metadata::Updater.new path
      metadata.files.each do |file|
        say "FILE = #{file.path}"
        print_tags file.get_tags
        say
      end

      say "Metadata list complete."
    end

    desc "-r, [--rebuild=PATH]", "Rebuild track metadata for given folder/file structure."
    map %w[-r --rebuild] => :rebuild
    def rebuild path
      say "Rebuilding metadata for: #{path}..."

      metadata = Metadata.new path
      metadata.rebuild { |file| say "Rebuilding: #{file.path}..." }

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

    # :reek:FeatureEnvy
    # :reek:NilCheck
    def print_tags tags = []
      tags.delete_if { |_, value| value.nil? || value == "" }
      tags.each { |key, value| say "#{key} = #{value}" }
    end
  end
end

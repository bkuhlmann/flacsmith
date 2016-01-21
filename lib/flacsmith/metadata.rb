# frozen_string_literal: true

module Flacsmith
  # Manages the rebuilding of FLAC file metadata.
  class Metadata
    attr_accessor :path

    def initialize path
      @path = path
    end

    def files
      file_paths.map { |file_path| Flacsmith::Flacfile.new file_path }
    end

    def rebuild
      files.each do |flacfile|
        flacfile.set_tags build_metadata(flacfile)
        yield flacfile if block_given?
        flacfile
      end
    end

    private

    def file_paths
      if path =~ /\.flac\Z/
        [path]
      else
        Dir["#{path}/**/*.flac"]
      end
    end

    def build_metadata flacfile
      path_nodes = flacfile.path.split File::SEPARATOR
      original_file = path_nodes.pop

      {
        "TRACKNUMBER" => Flacsmith::Flacfile.parse_number(original_file),
        "TITLE" => Flacsmith::Flacfile.parse_title(original_file),
        "ALBUM" => path_nodes.pop,
        "ARTIST" => path_nodes.pop
      }
    end
  end
end

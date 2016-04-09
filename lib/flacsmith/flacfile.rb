# frozen_string_literal: true

module Flacsmith
  # Represents a FLAC file.
  class Flacfile
    attr_accessor :path

    def self.allowed_methods
      %w[
        artist
        performer
        album
        genre
        organization
        tracknumber
        title
        description
        location
        contact
        license
        version
        copyright
        date
        isrc
      ]
    end

    def self.parse_number file_name
      file_name[/\A\d+/]
    end

    def self.parse_title file_name
      file_name.gsub(/^\d+/, "").strip.chomp ".flac"
    end

    def initialize path
      @path = File.expand_path path
    end

    def get_tag key
      result = `metaflac --show-tag="#{key}" "#{path}" 2> /dev/null`
      result.strip.gsub "#{key}=", ""
    end

    def get_tags keys = []
      keys = methods_to_keys(self.class.allowed_methods) if keys.empty?
      keys.reduce({}) { |hash, key| hash.merge! key => get_tag(key) }
    end

    def remove_tag key
      `metaflac --remove-tag="#{key}" "#{path}" 2> /dev/null`
    end

    def set_tag key, value
      # Remove before setting key due to a FLAC metadata flaw where duplicate keys can exist when set multiple times.
      remove_tag key
      `metaflac --set-tag="#{key}=#{value}" "#{path}" 2> /dev/null`
    end

    def set_tags tags = {}
      tags.each { |key, value| set_tag key, value }
    end

    def respond_to? name
      method_allowed?(name) || super(name)
    end

    def method_missing name, *args, &block
      if method_allowed?(name)
        send_to_getter_or_setter(name, *args, &block)
      else
        super(name, *args, &block)
      end
    end

    private

    def method_allowed? name
      self.class.allowed_methods.include? name.to_s.chomp("=")
    end

    def method_to_key name
      name.to_s.chomp("=").upcase
    end

    def methods_to_keys names
      names.map { |name| method_to_key name }
    end

    def send_to_getter_or_setter name, *args, &block
      key = method_to_key name

      if name =~ /=\Z/
        set_tag(*args.unshift(key), &block)
      else
        get_tag(key, &block)
      end
    end
  end
end

# frozen_string_literal: true

module Flacsmith
  # Gem identity information.
  module Identity
    def self.name
      "flacsmith"
    end

    def self.label
      "Flacsmith"
    end

    def self.version
      "7.0.0"
    end

    def self.version_label
      "#{label} #{version}"
    end
  end
end

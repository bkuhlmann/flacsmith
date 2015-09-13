module Flacsmith
  module Identity
    def self.name
      "flacsmith"
    end

    def self.label
      "Flacsmith"
    end

    def self.version
      "2.2.0"
    end

    def self.label_version
      [label, version].join " "
    end

    def self.file_name
      ".#{name}rc"
    end
  end
end

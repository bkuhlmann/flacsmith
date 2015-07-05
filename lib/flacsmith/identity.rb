module Flacsmith
  module Identity
    def self.name
      "flacsmith"
    end

    def self.label
      "Flacsmith"
    end

    def self.version
      "2.1.0"
    end

    def self.label_version
      [label, version].join " "
    end
  end
end

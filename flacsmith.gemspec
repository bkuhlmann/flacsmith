# frozen_string_literal: true

require_relative "lib/flacsmith/identity"

Gem::Specification.new do |spec|
  spec.name = Flacsmith::Identity::NAME
  spec.version = Flacsmith::Identity::VERSION
  spec.platform = Gem::Platform::RUBY
  spec.authors = ["Brooke Kuhlmann"]
  spec.email = ["brooke@alchemists.io"]
  spec.homepage = "https://www.alchemists.io/projects/flacsmith"
  spec.summary = "A command line interface for managing FLAC metadata."
  spec.license = "Apache-2.0"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/bkuhlmann/flacsmith/issues",
    "changelog_uri" => "https://www.alchemists.io/projects/flacsmith/changes.html",
    "documentation_uri" => "https://www.alchemists.io/projects/flacsmith",
    "source_code_uri" => "https://github.com/bkuhlmann/flacsmith"
  }

  spec.signing_key = Gem.default_key_path
  spec.cert_chain = [Gem.default_cert_path]

  spec.required_ruby_version = "~> 3.0"
  spec.add_dependency "refinements", "~> 8.0"
  spec.add_dependency "thor", "~> 0.20"

  spec.files = Dir["lib/**/*"]
  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
  spec.executables << "flacsmith"
  spec.require_paths = ["lib"]
end

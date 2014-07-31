$:.push File.expand_path("../lib", __FILE__)
require "flacsmith/version"

def add_security_key specification, method, files
  file = files.is_a?(Array) ? files.first : files
  if File.exists? file
    specification.send "#{method}=", files
  else
    puts "WARNING: Security key not found for #{specification.name} gem specification: #{file}"
  end
end

Gem::Specification.new do |s|
  s.name = "flacsmith"
  s.version = Flacsmith::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ["Brooke Kuhlmann"]
  s.email = ["brooke@redalchemist.com"]
  s.homepage = "https://github.com/bkuhlmann/flacsmith"
  s.summary = "A command line interface for managing FLAC metadata."
  s.description = "A command line interface and related utilities for managing FLAC metadata."
  s.license = "MIT"

  add_security_key s, "signing_key", File.expand_path("~/.ssh/gem-private.pem")
  add_security_key s, "cert_chain", [File.expand_path("~/.ssh/gem-public.pem")]

  case Gem.ruby_engine
    when "ruby"
      s.add_development_dependency "pry-byebug"
      s.add_development_dependency "pry-stack_explorer"
    when "jruby"
      s.add_development_dependency "pry-nav"
    when "rbx"
      s.add_development_dependency "pry-nav"
      s.add_development_dependency "pry-stack_explorer"
    else
      raise RuntimeError.new("Unsupported Ruby Engine!")
  end

  s.add_dependency "thor", "~> 0.19"
  s.add_dependency "thor_plus", "~> 1.6"
  s.add_development_dependency "rake"
  s.add_development_dependency "pry"
  s.add_development_dependency "pry-remote"
  s.add_development_dependency "pry-rescue"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rb-fsevent" # Guard file events for OSX.
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "codeclimate-test-reporter"

  s.files = Dir["lib/**/*", "vendor/**/*"]
  s.extra_rdoc_files = Dir["README*", "LICENSE*"]
  s.executables << "flacsmith"
  s.require_paths = ["lib"]
end

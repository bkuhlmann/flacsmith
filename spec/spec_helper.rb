require "bundler/setup"

if ENV["CODECLIMATE_REPO_TOKEN"]
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

require "flacsmith"
require "pry"
require "pry-remote"
require "pry-rescue"

case Gem.ruby_engine
  when "ruby"
    require "pry-byebug"
    require "pry-stack_explorer"
  when "jruby"
    require "pry-nav"
  when "rbx"
    require "pry-nav"
    require "pry-stack_explorer"
end

Dir[File.join(File.dirname(__FILE__), "support/kit/**/*.rb")].each { |file| require file }

RSpec.configure do |config|
  config.before do
    temp_dir = File.join File.dirname(__FILE__), "../tmp"
    FileUtils.rm_rf temp_dir
    FileUtils.mkdir temp_dir
  end
end

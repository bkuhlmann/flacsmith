# frozen_string_literal: true

require "spec_helper"
require "flacsmith/cli"

RSpec.describe Flacsmith::CLI do
  describe ".start" do
    let(:options) { [] }
    let(:command_line) { Array(command).concat options }
    let(:cli) { -> { described_class.start command_line } }

    shared_examples_for "a version command" do
      it "prints version" do
        expect(&cli).to output(/#{Flacsmith::Identity.label}\s#{Flacsmith::Identity.version}\n/).to_stdout
      end
    end

    shared_examples_for "a help command" do
      it "prints usage" do
        expect(&cli).to output(/#{Flacsmith::Identity.label}\s#{Flacsmith::Identity.version}\scommands:\n/).to_stdout
      end
    end

    describe "--version" do
      let(:command) { "--version" }
      it_behaves_like "a version command"
    end

    describe "-v" do
      let(:command) { "-v" }
      it_behaves_like "a version command"
    end

    describe "--help" do
      let(:command) { "--help" }
      it_behaves_like "a help command"
    end

    describe "-h" do
      let(:command) { "-h" }
      it_behaves_like "a help command"
    end

    context "with no command" do
      let(:command) { nil }
      it_behaves_like "a help command"
    end
  end
end

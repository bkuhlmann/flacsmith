# frozen_string_literal: true

require "spec_helper"

RSpec.describe Flacsmith::CLI do
  describe ".start" do
    subject(:cli) { described_class.start command_line }

    let(:options) { [] }
    let(:command_line) { Array(command).concat options }

    shared_examples_for "a version command" do
      it "prints version" do
        pattern = /#{Flacsmith::Identity::VERSION_LABEL}\n/o
        result = -> { cli }
        expect(&result).to output(pattern).to_stdout
      end
    end

    shared_examples_for "a help command" do
      it "prints usage" do
        pattern = /#{Flacsmith::Identity::VERSION_LABEL}\scommands:\n/o
        result = -> { cli }
        expect(&result).to output(pattern).to_stdout
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

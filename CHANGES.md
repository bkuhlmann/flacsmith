# 6.0.0 (2019-01-01)

- Fixed Circle CI cache for Ruby version.
- Fixed Layout/EmptyLineAfterGuardClause cop issues.
- Fixed Markdown ordered list numbering.
- Fixed Rubocop RSpec/MultipleExpectations issue.
- Fixed Rubocop RSpec/NamedSubject issues.
- Added Circle CI Bundler cache.
- Added Rubocop RSpec gem.
- Updated Circle CI Code Climate test reporting.
- Updated README documentation.
- Updated Semantic Versioning links to be HTTPS.
- Updated to Contributor Covenant Code of Conduct 1.4.1.
- Updated to Gemsmith 13.0.0.
- Updated to Git Cop 3.0.0.
- Updated to RSpec 3.8.0.
- Updated to Reek 5.0.
- Updated to Refinements 6.0.0.
- Updated to Rubocop 0.57.0.
- Updated to Rubocop 0.58.0.
- Updated to Rubocop 0.60.0.
- Updated to Rubocop 0.61.x.
- Updated to Rubocop 0.62.0.
- Updated to Ruby 2.5.2.
- Updated to Ruby 2.5.3.
- Updated to Ruby 2.6.0.
- Removed Rubocop Lint/Void CheckForMethodsWithNoSideEffects check.
- Removed `--convert` option (use `--encode` instead).
- Refactored converters as encoders.
- Refactored number regular expression pattern.
- Refactored picture metadata as image metadata.

# 5.2.0 (2018-05-01)

- Updated project changes to use semantic versions.
- Updated to Gemsmith 12.0.0.
- Updated to Git Cop 2.2.0.
- Updated to Refinements 5.2.0.

# 5.1.0 (2018-04-01)

- Fixed gemspec issues with missing gem signing key/certificate.
- Added gemspec metadata for source, changes, and issue tracker URLs.
- Updated README license information.
- Updated gem dependencies.
- Updated to Circle CI 2.0.0 configuration.
- Updated to Refinements 5.1.0.
- Updated to Rubocop 0.53.0.
- Updated to Ruby 2.5.1.
- Removed Circle CI Bundler cache.
- Removed Gemnasium support.
- Removed Patreon badge from README.
- Refactored temp dir shared context as a pathname.

# 5.0.0 (2018-01-01)

- Updated Code Climate badges.
- Updated Code Climate configuration to Version 2.0.0.
- Updated to Apache 2.0 license.
- Updated to Rubocop 0.52.0.
- Updated to Ruby 2.4.3.
- Updated to Ruby 2.5.0.
- Removed documentation for secure installs.
- Refactored code to use Ruby 2.5.0 `Array#append` syntax.

# 4.4.1 (2017-11-19)

- Updated to Git Cop 1.7.0.
- Updated to Rake 12.3.0.

# 4.4.0 (2017-10-29)

- Added Bundler Audit gem.
- Added dynamic formatting of RSpec output.
- Updated CONTRIBUTING documentation.
- Updated GitHub templates.
- Updated gem dependencies.
- Updated to Git Cop 1.3.0.
- Updated to Rubocop 0.50.0.
- Updated to Rubocop 0.51.0.
- Updated to Ruby 2.4.2.
- Removed Pry State gem.

# 4.3.0 (2017-06-18)

- Added Circle CI support.
- Added Git Cop code quality task.
- Updated Guardfile to always run RSpec with documentation format.
- Updated README headers.
- Updated Rubocop configuration.
- Updated command line usage in CLI specs.
- Updated gem dependencies.
- Updated to Gemsmith 10.0.0.
- Updated to Ruby 2.4.1.
- Removed Thor+ gem.
- Removed Travis CI support.
- Refactored CLI version/help specs.

# 4.2.0 (2017-02-26)

- Fixed Travis CI configuration to not update gems.
- Added CLI `--convert` option for converting audio.
- Added FLAC album converter support.
- Added FLAC file metadata.
- Added FLAC metadata formatter.
- Added FLAC metadata tagger.
- Added FLAC picture metadata.
- Added FLAC tag metadata.
- Added FLAC track file converter support.
- Added Flacsmith-specific error support.
- Added Refinements gem.
- Added code quality Rake task.
- Added invalid metadata tag error.
- Updated README semantic versioning order.
- Updated RSpec configuration to output documentation when running.
- Updated RSpec spec helper to enable color output.
- Updated Rubocop Metrics/LineLength to 100 characters.
- Updated Rubocop Metrics/ParameterLists max to three.
- Updated Rubocop to import from global configuration.
- Updated Travis CI configuration to use latest RubyGems version.
- Updated contributing documentation.
- Updated gemspec to require Ruby 2.4.0 or higher.
- Updated to Rubocop 0.47.
- Updated to Ruby 2.4.0.
- Removed Code Climate code comment checks.
- Removed Flacfile object.
- Removed Rubocop Style/Documentation check.
- Removed `.bundle` directory from `.gitignore`.
- Refactored CLI to use new metadata objects.
- Refactored FLAC metadata updater as builder.
- Refactored Reek and Rubocop issues.

# 4.1.0 (2016-12-18)

- Fixed Rakefile support for RSpec, Reek, Rubocop, and SCSS Lint.
- Updated Circle CI configuration to use latest packages.
- Updated Travis CI configuration to use defaults.
- Updated to Gemsmith 8.2.x.
- Updated to Rake 12.x.x.
- Updated to Rubocop 0.46.x.
- Updated to Ruby 2.3.2.
- Updated to Ruby 2.3.3.

# 4.0.0 (2016-11-14)

- Fixed Rakefile to safely load Gemsmith tasks.
- Fixed Ruby pragma.
- Fixed contributing guideline links.
- Added CLI version and help specs.
- Added Code Climate engine support.
- Added GitHub issue and pull request templates.
- Added Reek support.
- Added Rubocop Style/SignalException cop style.
- Added `Gemfile.lock` to `.gitignore`.
- Added bond, wirb, hirb, and awesome_print development dependencies.
- Added frozen string literal pragma.
- Updated CLI command option documentation.
- Updated GitHub issue and pull request templates.
- Updated README secure gem install documentation.
- Updated README versioning documentation.
- Updated RSpec temp directory to use Bundler root path.
- Updated Rubocop PercentLiteralDelimiters and AndOr styles.
- Updated gemspec with conservative versions.
- Updated to Code Climate Test Reporter 1.0.0.
- Updated to Code of Conduct, Version 1.4.0.
- Updated to Gemsmith 7.7.0.
- Updated to Gemsmith 8.1.0.
- Updated to RSpec 3.5.0.
- Updated to Rubocop 0.44.
- Updated to Ruby 2.3.1.
- Updated to Thor+ 4.0.0.
- Removed CHANGELOG.md (use CHANGES.md instead).
- Removed Rake console task.
- Removed gem name from CLI version description.
- Removed gemspec description.
- Removed rb-fsevent development dependency from gemspec.
- Removed terminal notifier gems from gemspec.
- Refactored RSpec spec helper configuration.
- Refactored gemspec to use default security keys.
- Refactored source requirements.
- Refactored specs to *flacsmith* folder.

# 3.0.0 (2016-01-20)

- Added IRB development console Rake task support.
- Updated gem binary shebang comment format.
- Updated to Ruby 2.3.0.
- Removed RSpec default monkey patching behavior.
- Removed Ruby 2.1.x and 2.2.x support.

# 2.3.0 (2015-12-02)

- Fixed README URLs to use HTTPS schemes where possible.
- Fixed README test command instructions.
- Added Gemsmith development support.
- Added Identity module description.
- Added Patreon badge to README.
- Added Rubocop support.
- Added [pry-state](https://github.com/SudhagarS/pry-state) support.
- Added gem configuration file name to identity.
- Added gem label to CLI version description.
- Added package name to CLI.
- Added project name to README.
- Added table of contents to README.
- Updated Code Climate to run when CI ENV is set.
- Updated Code of Conduct 1.3.0.
- Updated README with Tocer generated Table of Contents.
- Updated RSpec support kit with new Gemsmith changes.
- Updated to Code Climate SVG badge icons.
- Updated to Ruby 2.2.3.
- Updated to SVG README icons.
- Removed GitTip badge from README.
- Removed Travis CI Docker requirements.
- Removed unnecessary exclusions from .gitignore.

# 2.2.0 (2015-07-05)

- Removed JRuby support (no longer officially supported).
- Fixed secure gem installs (new cert has 10 year lifespan).
- Updated to Ruby 2.2.2.
- Added CLI process title support.
- Added code of conduct documentation.

# 2.1.0 (2015-03-12)

- Fixed bug where track label prefixed with numbers would be lost.
- Updated to Ruby 2.2.1.

# 2.0.0 (2015-01-01)

- Removed Ruby 2.0.0 support.
- Removed Rubinius support.
- Updated to Ruby 2.2.0.
- Updated to Thor+ 2.x.x.
- Updated spec helper to comment custom config until needed.
- Updated gemspec to use RUBY_GEM_SECURITY env var for gem certs.

# 1.0.0 (2014-10-22)

- Updated to Ruby 2.1.3.
- Updated to Rubinius 2.2.10.
- Updated gemspec to add security keys unless in a CI environment.
- Updated Code Climate to run only if environment variable is present.
- Updated gemspec author email address.
- Added author and email arrays to gemspec.
- Added the Guard Terminal Notifier gem.
- Added silencing of metaflac native errors.
- Refactored RSpec configuration, support, and kit folders.

# 0.2.0 (2014-07-06)

- Added Code Climate test coverage support.
- Updated to Ruby 2.1.2.
- Updated file metadata rebuilding messages to say "Rebuilding" instead of "processing".
- Updated gem-public.pem for gem install certificate chain.

# 0.1.0 (2014-04-21)

- Initial version.

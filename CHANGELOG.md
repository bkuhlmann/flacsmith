# v2.2.0 (2015-07-05)

- Removed JRuby support (no longer officially supported).
- Fixed secure gem installs (new cert has 10 year lifespan).
- Updated to Ruby 2.2.2.
- Added CLI process title support.
- Added code of conduct documentation.

# v2.1.0 (2015-03-12)

- Fixed bug where track label prefixed with numbers would be lost.
- Updated to Ruby 2.2.1.

# v2.0.0 (2015-01-01)

- Removed Ruby 2.0.0 support.
- Removed Rubinius support.
- Updated to Ruby 2.2.0.
- Updated to Thor+ 2.x.x.
- Updated spec helper to comment custom config until needed.
- Updated gemspec to use RUBY_GEM_SECURITY env var for gem certs.

# v1.0.0 (2014-10-22)

- Updated to Ruby 2.1.3.
- Updated to Rubinius 2.2.10.
- Updated gemspec to add security keys unless in a CI environment.
- Updated Code Climate to run only if environment variable is present.
- Updated gemspec author email address.
- Added author and email arrays to gemspec.
- Added the Guard Terminal Notifier gem.
- Added silencing of metaflac native errors.
- Refactored RSpec configuration, support, and kit folders.

# v0.2.0 (2014-07-06)

- Added Code Climate test coverage support.
- Updated to Ruby 2.1.2.
- Updated file metadata rebuilding messages to say "Rebuilding" instead of "processing".
- Updated gem-public.pem for gem install certificate chain.

# v0.1.0 (2014-04-21)

- Initial version.

# Flacsmith

[![Gem Version](https://badge.fury.io/rb/flacsmith.svg)](http://badge.fury.io/rb/flacsmith)
[![Code Climate GPA](https://codeclimate.com/github/bkuhlmann/flacsmith.svg)](https://codeclimate.com/github/bkuhlmann/flacsmith)
[![Code Climate Coverage](https://codeclimate.com/github/bkuhlmann/flacsmith/coverage.svg)](https://codeclimate.com/github/bkuhlmann/flacsmith)
[![Gemnasium Status](https://gemnasium.com/bkuhlmann/flacsmith.svg)](https://gemnasium.com/bkuhlmann/flacsmith)
[![Travis CI Status](https://secure.travis-ci.org/bkuhlmann/flacsmith.svg)](https://travis-ci.org/bkuhlmann/flacsmith)
[![Patreon](https://img.shields.io/badge/patreon-donate-brightgreen.svg)](https://www.patreon.com/bkuhlmann)

This is a Ruby wrapper for the [FLAC](https://xiph.org/flac) commands. It aids in listing/rebuilding
metadata for a music collection, artist, album, or song. Having metadata information that reflects
the directory/file structure makes organizing and managing large music collections easier. This can
be especially useful with tools like [Audacity](http://audacity.sourceforge.net),
[VLC](https://www.videolan.org/vlc/index.html), and/or [Sonos](http://www.sonos.com) (to name a
few).

<!-- Tocer[start]: Auto-generated, don't remove. -->

# Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Setup](#setup)
- [Usage](#usage)
- [Tests](#tests)
- [Versioning](#versioning)
- [Code of Conduct](#code-of-conduct)
- [Contributions](#contributions)
- [License](#license)
- [History](#history)
- [Credits](#credits)

<!-- Tocer[finish]: Auto-generated, don't remove. -->

# Features

- Lists metadata for a file, album, artist, or music collection.
- Rebuilds metadata for a file, album, artist, or music collection.

# Requirements

0. A UNIX-based system.
0. [Ruby 2.4.x](https://www.ruby-lang.org).
0. [FLAC](https://xiph.org/flac) (for OSX, run: `brew install flac`).

# Setup

For a secure install, type the following from the command line (recommended):

    gem cert --add <(curl --location --silent https://www.alchemists.io/gem-public.pem)
    gem install flacsmith --trust-policy MediumSecurity

NOTE: A HighSecurity trust policy would be best but MediumSecurity enables signed gem verification
while allowing the installation of unsigned dependencies since they are beyond the scope of this
gem.

For an insecure install, type the following (not recommended):

    gem install flacsmith

# Usage

From the command line, type: pennyworth

    flacsmith -C, [--convert=INPUT_DIR OUTPUT_DIR]  # Convert source audio to FLAC audio.
    flacsmith -h, [--help=COMMAND]                  # Show this message or get help for a command.
    flacsmith -l, [--list=PATH]                     # List track metadata for given folder/file structure.
    flacsmith -r, [--rebuild=PATH]                  # Rebuild track metadata for given folder/file structure.
    flacsmith -v, [--version]                       # Show gem version.

The following directory structure is assumed:

    /<artist>/<album>/<tracknumber> <title>.flac

This is important because metadata for a file is always rebuilt by inspecting the absolute path to
the file which assumes that a song is nested within an artist and album folder and has a track
number followed by a title. This convention over configuration technique allows metadata to be
rebuilt by inspecting the absolute path of the file. This also means that the `--rebuild` option can
be applied to a single song, album, artist, or a complete music collection.

The following is an example of possible workflows:

- Convert AIFF files to FLAC files:
  0. Run: `flacsmith -C <input dir> <output dir>`
- List metadata for an artist:
  0. Run: `flacsmith -l <artist>`
- List metadata for an album:
  0. Run: `flacsmith -l <artist>/<album>`
- List metadata for collection:
  0. Run: `flacsmith -l .`
- Rebuild metadata for a new album:
  0. Copy the album to `<collecton>/<artist>/<album>`
  0. Run: `flacsmith -r <collecton>/<artist>/<album>`
- Rebuild metadata for a song:
  0. Change directory to `<collecton>/<artist></album>`
  0. Run: `mv <old name>.flac` to `<new name>.flac`
  0. Run: `flacsmith -r <new name>.flac`
- Rebuild metadata for entire music collection:
  0. Run: `flacsmith -r .`

# Tests

To test, run:

    bundle exec rake

# Versioning

Read [Semantic Versioning](http://semver.org) for details. Briefly, it means:

- Major (X.y.z) - Incremented for any backwards incompatible public API changes.
- Minor (x.Y.z) - Incremented for new, backwards compatible, public API enhancements/fixes.
- Patch (x.y.Z) - Incremented for small, backwards compatible, bug fixes.

# Code of Conduct

Please note that this project is released with a [CODE OF CONDUCT](CODE_OF_CONDUCT.md). By
participating in this project you agree to abide by its terms.

# Contributions

Read [CONTRIBUTING](CONTRIBUTING.md) for details.

# License

Copyright (c) 2014 [Alchemists](https://www.alchemists.io).
Read [LICENSE](LICENSE.md) for details.

# History

Read [CHANGES](CHANGES.md) for details.
Built with [Gemsmith](https://github.com/bkuhlmann/gemsmith).

# Credits

Developed by [Brooke Kuhlmann](https://www.alchemists.io) at
[Alchemists](https://www.alchemists.io).

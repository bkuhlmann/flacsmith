<p align="center">
  <img src="FLACsmith.png" alt="FLACsmith Icon"/>
</p>

# FLACsmith

[![Gem Version](https://badge.fury.io/rb/flacsmith.svg)](http://badge.fury.io/rb/flacsmith)
[![Code Climate Maintainability](https://api.codeclimate.com/v1/badges/1c9fab2b1d26ad819817/maintainability)](https://codeclimate.com/github/bkuhlmann/flacsmith/maintainability)
[![Code Climate Test Coverage](https://api.codeclimate.com/v1/badges/1c9fab2b1d26ad819817/test_coverage)](https://codeclimate.com/github/bkuhlmann/flacsmith/test_coverage)
[![Circle CI Status](https://circleci.com/gh/bkuhlmann/flacsmith.svg?style=svg)](https://circleci.com/gh/bkuhlmann/flacsmith)

This is a Ruby wrapper for the [FLAC](https://xiph.org/flac) commands. It aids in listing/rebuilding
metadata for a music collection, artist, album, or song. Having metadata information that reflects
the directory/file structure makes organizing and managing large music collections easier. This can
be especially useful with tools like [Audacity](http://audacity.sourceforge.net),
[VLC](https://www.videolan.org/vlc/index.html), and/or [Sonos](http://www.sonos.com) (to name a
few).

<!-- Tocer[start]: Auto-generated, don't remove. -->

## Table of Contents

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

## Features

- Converts source audio (AIFF) to FLAC.
- Rebuilds metadata for a file, album, artist, or music collection.
- Lists metadata for a file, album, artist, or music collection.

## Requirements

1. A UNIX-based system.
1. [Ruby 2.7.x](https://www.ruby-lang.org).
1. [FLAC](https://xiph.org/flac) (i.e. `brew install flac`).

## Setup

Type the following to install:

    gem install flacsmith

## Usage

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
  - Run: `flacsmith -C <input dir> <output dir>`
- List metadata for an artist:
  - Run: `flacsmith -l <artist>`
- List metadata for an album:
  - Run: `flacsmith -l <artist>/<album>`
- List metadata for collection:
  - Run: `flacsmith -l .`
- Rebuild metadata for a new album:
  - Copy the album to `<collecton>/<artist>/<album>`
  - Run: `flacsmith -r <collecton>/<artist>/<album>`
- Rebuild metadata for a song:
  - Change directory to `<collecton>/<artist></album>`
  - Run: `mv <old name>.flac` to `<new name>.flac`
  - Run: `flacsmith -r <new name>.flac`
- Rebuild metadata for entire music collection:
  - Run: `flacsmith -r .`

## Tests

To test, run:

    bundle exec rake

## Versioning

Read [Semantic Versioning](https://semver.org) for details. Briefly, it means:

- Major (X.y.z) - Incremented for any backwards incompatible public API changes.
- Minor (x.Y.z) - Incremented for new, backwards compatible, public API enhancements/fixes.
- Patch (x.y.Z) - Incremented for small, backwards compatible, bug fixes.

## Code of Conduct

Please note that this project is released with a [CODE OF CONDUCT](CODE_OF_CONDUCT.md). By
participating in this project you agree to abide by its terms.

## Contributions

Read [CONTRIBUTING](CONTRIBUTING.md) for details.

## License

Copyright 2014 [Alchemists](https://www.alchemists.io).
Read [LICENSE](LICENSE.md) for details.

## History

Read [CHANGES](CHANGES.md) for details.
Built with [Gemsmith](https://github.com/bkuhlmann/gemsmith).

## Credits

Developed by [Brooke Kuhlmann](https://www.alchemists.io) at
[Alchemists](https://www.alchemists.io).

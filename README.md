# Overview

[![Gem Version](https://badge.fury.io/rb/flacsmith.png)](http://badge.fury.io/rb/flacsmith)
[![Code Climate GPA](https://codeclimate.com/github/bkuhlmann/flacsmith.png)](https://codeclimate.com/github/bkuhlmann/flacsmith)
[![Gemnasium Status](https://gemnasium.com/bkuhlmann/flacsmith.png)](https://gemnasium.com/bkuhlmann/flacsmith)
[![Travis CI Status](https://secure.travis-ci.org/bkuhlmann/flacsmith.png)](http://travis-ci.org/bkuhlmann/flacsmith)
[![Coveralls Status](https://coveralls.io/repos/bkuhlmann/flacsmith/badge.png)](https://coveralls.io/r/bkuhlmann/flacsmith)

This is a Ruby wrapper for the [FLAC](https://xiph.org/flac)
[metaflac](https://xiph.org/flac/documentation_tools_metaflac.html) command line interface (CLI). It aids in
listing/rebuilding metadata for a music collection, artist, album, or song. Having metadata information that reflects
the directory/file structure makes organizing and managing large music collections easier. This can be especially useful
with tools like [Audacity](http://audacity.sourceforge.net), [VLC](https://www.videolan.org/vlc/index.html), and/or
[Sonos](http://www.sonos.com) (to name a few).

# Features

* Lists metadata for a file, album, artist, or music collection.
* Rebuilds metadata for a file, album, artist, or music collection.

# Requirements

0. A UNIX-based system.
0. Any of the following Ruby VMs:
    * [MRI 2.x.x](http://www.ruby-lang.org)
    * [JRuby 1.x.x](http://jruby.org)
    * [Rubinius 2.x.x](http://rubini.us)
0. [FLAC](https://xiph.org/flac) (for OSX, run: `brew install flac`).

# Setup

For a secure install, type the following from the command line (recommended):

    gem cert --add <(curl -Ls http://www.redalchemist.com/gem-public.pem)
    gem install flacsmith --trust-policy MediumSecurity

NOTE: A HighSecurity trust policy would be best but MediumSecurity enables signed gem verification while
allowing the installation of unsigned dependencies since they are beyond the scope of this gem.

For an insecure install, type the following (not recommended):

    gem install flacsmith

# Usage

From the command line, type: pennyworth

    flacsmith -h, [--help=HELP]  # Show this message or get help for a command.
    flacsmith -l, [--list]       # List track metadata for given folder/file structure.
    flacsmith -r, [--rebuild]    # Rebuild track metadata for given folder/file structure.
    flacsmith -v, [--version]    # Show version.

The following directory structure is assumed:

    /<artist>/<album>/<tracknumber> <title>.flac

This is important because metadata for a file is always rebuilt by inspecting the absolute path to the file which
assumes that a song is nested within an artist and album folder and has a track number followed by a title. This
convention over configuration technique allows metadata to be rebuilt by inspecting the absolute path of the file. This
also means that the `--rebuild` option can be applied to a single song, album, artist, or a complete music collection.

The following is an example of possible workflows:

* List metadata for an artist:
    0. Chage directory to `<music collecton>`
    0. Run: `flacsmith -l "<artist>"`
* List metadata for an album:
    0. Chage directory to `<music collecton>/<artist>/<album>`
    0. Run: `flacsmith -l .`
* Rebuild metadata for a new album:
    0. Copy the album to `<music collecton>/<artist>/<album>`
    0. Chage directory to `<music collecton>/<artist>`
    0. Run: `flacsmith -r "<album>"`
* Rebuild metadata for a song:
    0. Change directory to `<music collecton>/<artist></album>`
    0. Run: `mv "<old name>.flac" to "<new name>.flac"`
    0. Run: `flacsmith -r "<new name>.flac"`
* Rebuild metadata for entire music collection:
    0. Run: `flacsmith -r "<music collection>"`

# Tests

To test, do the following:

0. cd to the gem root.
0. bundle install
0. bundle exec rspec spec

# Versioning

Read [Semantic Versioning](http://semver.org) for details. Briefly, it means:

* Patch (x.y.Z) - Incremented for small, backwards compatible bug fixes.
* Minor (x.Y.z) - Incremented for new, backwards compatible public API enhancements and/or bug fixes.
* Major (X.y.z) - Incremented for any backwards incompatible public API changes.

# Contributions

Read CONTRIBUTING for details.

# Credits

Developed by [Brooke Kuhlmann](http://www.redalchemist.com) at [Red Alchemist](http://www.redalchemist.com).

# License

Copyright (c) 2014 [Red Alchemist](http://www.redalchemist.com).
Read the LICENSE for details.

# History

Read the CHANGELOG for details.
Built with [Gemsmith](https://github.com/bkuhlmann/gemsmith).

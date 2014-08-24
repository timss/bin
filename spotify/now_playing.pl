#!/usr/bin/perl -I .

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin";
use Playing;

my ($artist, $album, $song) = get_now_playing();

print "Artist: $artist\n" .
      "Album:  $album\n" .
      "Song:   $song\n";

system("echo \"Now playing: $artist - $album - $song\" | xclip -selection c")

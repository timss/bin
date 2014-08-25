#!/usr/bin/perl -I .

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin";
use Playing;

my ($artist, $album, $song, $url) = get_now_playing();

print "echo np: Artist: $artist | Album: $album | Song: $song | URL: $url\n"

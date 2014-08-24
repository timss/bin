#!/usr/bin/perl

package Playing;
use Exporter;
@ISA    = qw(Exporter);
@EXPORT = qw(get_now_playing);

use strict;
use warnings;

sub get_now_playing() {
    open(my $METADATA, "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata'|")
        or die "Error while querying the dbus.\n";
    my @metadata = <$METADATA>;
    close($METADATA);

    # if length = < 4, no song playing
    if(@metadata < 4) {
        print "No song currently playing.\n";
        exit 1;
    }

    my $artist = ($metadata[21] =~ /\"(.*)\"/)[0]; # string "Artist"
    my $album  = ($metadata[16] =~ /\"(.*)\"/)[0]; # variant string "Album"
    my $song   = ($metadata[38] =~ /\"(.*)\"/)[0]; # variant string "Song"

    return ($artist, $album, $song);
}

1;

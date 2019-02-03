#!/usr/bin/perl
use strict;
use warnings;

while (<>) {
    s/[\r\n]//g;
    s/\[3m%\[23m/[3m[23m/g;

    while (/^(.*?)(+)(.*)$/) {
        my ($head, $space, $tail) = ($1, $2, $3);
        $head =~ s/\[\d+m//g;
        $head = substr($head, 0, length($head)-length($space));
        $_ = $head . $tail
    }

    while (/^(.*?)\[(\d+)D(.*)$/) {
        my ($head, $delete, $tail) = ($1, $2, $3);
        $head =~ s/\[\d+m//g;
        $head = substr($head, 0, length($head)-$delete);
        $_ = $head . $tail
    }

    s/\[J/\n/g;

    s/\[\?2004[hl]//g;

    print $_ . "\n";
}


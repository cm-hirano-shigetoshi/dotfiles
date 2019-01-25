#!/usr/bin/perl
use strict;
use warnings;

while (<>) {
    s/[\r\n]//g;

    s/\[3m%\[23m/[3m[23m/g;

    while (/^(.*?)(+)(.*)$/) {
        my ($head, $space, $tail) = ($1, $2, $3);
        $head = substr($head, 0, length($head)-length($space));
        $_ = $head . $tail
    }

    while (/^(.*?)\[(\d+)D +\[(\d+)D(.*)$/) {
        my ($head, $space, $tail) = ($1, $2, $4);
        $head = substr($head, 0, length($head)-$space);
        $_ = $head . $tail
    }

    s/\[J/\n/g;

    s/\[\?2004[hl]//g;

    print $_ . "\n";
}


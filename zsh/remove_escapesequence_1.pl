#!/usr/bin/perl
use strict;
use warnings;

my $flag = 0;
while (<>) {
    my $buf = $_;
    while (length($buf) > 0) {
        ($buf, $flag) = &analyze($buf, $flag);
    }
}

sub analyze {
    my $flag;
    ($_, $flag) = @_;

    if ($flag == 0 && /^(.*?)\[\?1049h\[\?1000h(.*)$/) {
        print $1;
        return ($2, 2049)
    }
    if ($flag == 0 && /^(.*?)\[\?1049h(.*)$/) {
        print $1;
        return ($2, 1049)
    }
    if ($flag == 0 && /^(.*?)\]0;(.*)$/) {
        print $1;
        return ($2, -1)
    }

    if ($flag == 2049 && /\[\?1049l\[\?1000l(.*)$/) {
        return ($1."\n", 0);
    }
    if ($flag == 1049 && /\[\?1049l(.*)$/) {
        return ($1."\n", 0);
    }
    if ($flag == -1 && /\\(.*?)$/) {
        return ($1."\n", 0);
    }

    if ($flag == 0) {
        print $_;
    }
    return ("", $flag);
}


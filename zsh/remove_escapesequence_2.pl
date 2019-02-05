#!/usr/bin/perl
use strict;
use warnings;

while (<>) {
    s/[\r\n]//g;
    s/\[3m%\[23m/[3m[23m/g;
    s/\[J/\n/g;
    s/\[\?2004[hl]//g;

    $_ = &seq($_);

    print $_ . "\n";
}

sub seq {
    my @buf = ();
    my $pos = 0;
    my @chars = split(//, $_[0]);
    for (my $i=0; $i<scalar(@chars); $i++) {
        my $c = $chars[$i];
        if ($c eq "") {
            $pos--;
        } elsif ($c eq "") {
            if ($chars[$i+1] eq "[") {
                my $j = 2;
                my $num = "";
                for (; $chars[$i+$j] =~ /[0-9;]/; $j++) {
                    $num .= $chars[$i+$j];
                }
                my $alpha = $chars[$i+$j];
                $i += $j;
                #print STDERR "\\e[$num$alpha";

                if ($alpha eq "C") {
                    $pos += $num;
                } elsif ($alpha eq "D") {
                    $pos -= $num;
                } else {
                    # do nothing.
                }
            }
        } else {
            if ($pos <= $#buf) {
                $buf[$pos++] = $c;
            } else {
                push(@buf, $c);
                $pos++;
            }
        }
    }
    return join("", @buf);
}


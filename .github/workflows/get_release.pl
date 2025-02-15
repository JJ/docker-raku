#!/usr/bin/env perl

use strict;
use warnings;


my $dockerfile = do { local(@ARGV, $/) = "Dockerfile"; <> };
my ($version) = $dockerfile =~ /RAKU_RELEASE=(\d+\.\d+)/;
print $version;

#!/usr/bin/env perl

use strict;
use warnings;

my $infile = $ARGV[0];

open (IN, "$infile") or die "Cannot open file $infile $!\n";

while (<IN>){
  # skip lines beginning #
  unless ($_ =~ /^#/){
    my @data = split(/\s+/, $_, 27);

    # Clean up bitscore
    my @value_array = (split/\./, $data[14]);
    my $bit_score = $value_array[0];
    if ($bit_score > 1000){
      $bit_score = 1000;
    }

    my $chromosome = $data[3];
    my $chromStart = -1;
    my $chromEnd = -1;
    my $name = $data[1];
    my $strand = $data[11];
    # start must be lower than end - so the two need reversing if strand = '-'
    if ($strand eq '+'){
      $chromStart = $data[9];
      $chromEnd = $data[10];
    } elsif ($strand eq '-'){
      $chromStart = $data[10];
      $chromEnd = $data[9];
    } else {
      print "Strand character ($strand) unrecognised in line: $_";
      continue;
    }

    # See: https://genome.ucsc.edu/FAQ/FAQformat.html#format1
    print "$chromosome\t$chromStart\t$chromEnd\t$name\t$bit_score\t$strand\n";
  }

} #end of loop through infile
close (IN);

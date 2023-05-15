#!/usr/bin/env perl

use strict;
use warnings;

my $infile = $ARGV[0];

open (IN, "$infile") or die "Cannot open file $infile $!\n";

while (<IN>){
  # skip lines beginning #
  unless ($_ =~ /^#/){
    my @data = split(/\s+/,$_);

    # need to ignore those where chrom is non-standard
    if ($data[0] =~ /chr\w{1,2}_\S+/){
      next;
    }

    # Clean up bitscore
    my @value_array = (split/\./, $data[14]);
    my $bit_score = $value_array[0];
    if ($bit_score > 1000){
      $bit_score = 1000;
    }

    # start must be lower than end - so the two need reversing if strand = '-'
    if ($data[9] eq '+'){
      print "$data[0]\t$data[7]\t$data[8]\t$data[2]\t$bit_score\t$data[9]\n";
    } elsif ($data[9] eq '-'){
      print "$data[0]\t$data[8]\t$data[7]\t$data[2]\t$bit_score\t$data[9]\n";
    } else {
      print "Strand character unrecognised in line: $_";
    }
  }

} #end of loop through infile
close (IN);

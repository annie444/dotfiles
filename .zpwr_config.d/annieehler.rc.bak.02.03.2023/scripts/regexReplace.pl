#!/usr/bin/env perl
#{{{                    MARK:Header
#**************************************************************
#####   Author: JACOBMENKE
#####   Date: Wed Jun 20 11:37:12 EDT 2018
#####   Purpose: perl script to remove carriage returns
#####   Notes: works recursively
#}}}***********************************************************

use strict;
use warnings;
use feature qw/say/;

use Getopt::Long;

my @files       = ();
my $regex       = '\r';
my $replacement = "";
my $help        = 0;

sub usage {
    select STDERR;
    say "Use --regex or --replacement to specify strings.";
    say
"Usage: regexReplace.pl [-h|--help] [--regex=REGEX] [--replacement=STRING]";
    say "    [-h|--help] show this message";
    say "    [--regex] REGEX replace this REGEX";
    say "    [--replacement] STRING replace regex with this STRING";
    exit 1;
}

GetOptions(
    'help|h'        => \$help,
    'regex=s'       => \$regex,
    'replacement=s' => \$replacement
);

usage if $help;

sub addToAry {
    if ( -d $_[0] ) {
        if ( $_[0] =~ /\.git/ ) {
            return;
        }
        addToAry $_ for glob("$_[0]/* $_[0]/.[!.]*");
    }
    else {
        say "<<<($_[0])>>>";
        my $type = `file $_[0]`;
        if ( $type =~ /text/ ) {
            my $out = `cat $_[0]`;
            if ( $out =~ /$regex/ ) {
                say
"\x1b[34;1m<<<(\x1b[0;34m$_[0]\x1b[0m has got \x1b[34m$regex!\x1b[0;34;1m)>>>\x1b[0m";
                push @files, $_[0];
            }
        }
    }
}

addToAry $_ for @ARGV;
my $length = scalar @files;

if ($length) {

    #open $less, "|-","less -MN" or die $!;
    #select $less;
    say "";
    say "*" x 80 for ( 0 .. 2 );
    say "";
    say
"\x1b[34;1m<<<(\x1b[0;34m$_\x1b[0m has got \x1b[34m$regex!\x1b[0;34;1m)>>>\x1b[0m"
      for @files;

    say
      "\x1b[34;1m<<<(\x1b[0;34m$length \x1b[0;34mfiles!\x1b[0;34;1m)>>>\x1b[0m";
    print "Remove $regex?\x1b[1;34m>\x1b[0m ";
    my $answer = <STDIN>;
    chomp $answer;
    if ( $answer =~ /y|yes/i ) {
        `perl -i -pe 's#$regex#$replacement#g' "$_"` for @files;
    }
    else {
        say "bye";
    }

    #close $less;
}


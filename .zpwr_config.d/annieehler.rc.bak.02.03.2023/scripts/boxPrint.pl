#!/usr/bin/env perl
#{{{                    MARK:Header
#**************************************************************
##### Author: WIZARD
##### Date: Fri Nov 16 21:18:20 EST 2018
##### Purpose: perl script to print boxes around text
##### Notes:
#}}}***********************************************************

use strict;
use warnings;
use feature qw/say/;

use POSIX;
use Getopt::Long;

my $full  = 0;
my $width = 0;
my $help  = 0;

sub usage {
    select STDERR;
    say "Usage: boxPrint.pl [-h|--help] [-f|--full]";
    say "    [-h|--help] show this message";
    say "    [-f|--full] center box across width of terminal";
    exit 1;
}

GetOptions( 'help|h' => \$help, 'full|f' => \$full ) or usage;

usage if $help;

if ($full) {
    $width = 80;
}
else {
    $width = `tput cols`;
    if ( $width == 80 ) {
        if ( defined $ENV{'COLUMNS'} ) {
            $width = $ENV{'COLUMNS'};
        }
    }

    if ( $width % 2 == 1 ) {
        $width -= 1;
    }
    else {
        $width -= 2;
    }
}

my $str          = '';
my $boxColor     = "\x1b[0;32;1m";
my $textColor    = "\x1b[0;34;4m";
my $resetColor   = "\x1b[0m";
my $spacerLength = 2;
my $boxesChar    = '/';
my $spaceChar    = ' ';
my $boxWidth     = 4;

if (@ARGV) {
    $str .= "$_ " for @ARGV;
}
else {
    while (<STDIN>) {
        chomp;
        s@\s+@ @g;
        $str .= $_;
    }
}

my $inputStringLength = length $str;

my $sideCharacterLength =
  ( ( $width - $inputStringLength - $spacerLength * 2 ) + 1 ) / 2;

my $proposedTextLength = $inputStringLength + $spacerLength * 2 + $boxWidth;
my $maxTextLength      = $width - ( ( $spacerLength * 2 ) + $boxWidth );

if ( $proposedTextLength > $maxTextLength ) {

    my $lineCounter       = int( $inputStringLength / $maxTextLength ) + 1;
    my $charactersPerLine = int( $inputStringLength / $lineCounter );
    my $numSideCharLength =
      int( int( $width - $charactersPerLine - $boxWidth ) / 2 );

    print "$boxColor";
    say $boxesChar x $width;

    for ( my $i = 0 ; $i < $lineCounter ; ++$i ) {

        my $startIndex = $charactersPerLine * $i;

        print $boxesChar x $numSideCharLength;
        print $spaceChar x $spacerLength;
        print "$textColor";

        print substr $str, $startIndex, $charactersPerLine;

        print $spaceChar x $spacerLength;
        print "$boxColor";
        print $boxesChar x $numSideCharLength;
        print "\n";
    }

    say $boxesChar x $width;

}
else {
    my $side2len = $sideCharacterLength;

    if ( $inputStringLength % 2 ) {
        --$side2len;
    }

    print "$boxColor";
    say $boxesChar x $width;
    print $boxesChar x $sideCharacterLength;
    print $spaceChar x $spacerLength;
    print "$textColor";
    print $str;
    print "$boxColor";
    print $spaceChar x $spacerLength;
    say $boxesChar x $side2len;
    say $boxesChar x $width;
}

print "$resetColor";

#!/usr/bin/env perl

use strict;
use warnings;
use feature qw/ say /;
use YAML qw/LoadFile/;
use Data::Dumper;
use Date::Calc qw/ Decode_Month /;
use FileHandle;

my %talks = ();

foreach my $file (<*.yaml>) {
	say $file;
	my $yaml = LoadFile($file);
	foreach my $meeting (@{ $yaml }) {
		my $month = Decode_Month( $meeting->{month} );
		$talks{by_date}{ $meeting->{year} }{ $month } = { %{ $meeting } };
		foreach my $talk (@{ $meeting->{talks} }) {
			$talks{by_author}{ $talk->{author} } { $meeting->{year} }{ $month } ||= [];
			$talk->{month} = $meeting->{month};
			warn Dumper $talk;
			push(@{ $talks{by_author}{ $talk->{author} } { $meeting->{year} }{ $month } }, { %{ $talk } });
		}
	}
}
my $fh = FileHandle->new(">talks.data");
$fh->print(Data::Dumper->Dump([\%talks], [qw/$talks/]));
$fh->close;




#!/usr/bin/env perl
use strict;
use warnings;
use LWP::Simple;
use HTML::Parser ();
use FileHandle;

our @tokens = ();
my $last_token;
our %talks = ();

# Create parser object
my  $p = HTML::Parser->new( api_version => 3,
                         start_h => [\&start, "tagname, attr"],
                         end_h   => [\&end,   "tagname"],
						 text_h  => [\&text, "dtext"],
                         marked_sections => 0,
                       );


use Data::Dumper;
my $content = get('http://miltonkeynes.pm.org/');
$p->parse($content);
$p->eof;                 # signal end of document
my $fh = FileHandle->new("> talks.pl");
$fh->print(Data::Dumper->Dump([\%talks], [qw/$talks/]));
$fh->close;
=pod
my @links = $mech->find_all_links(url_regex => qr/^talks/) or die $!;
foreach my $link (@links) {
	print Dumper($link);
}
=cut;

sub text {
	return if $_[0] =~ m!^\s*$!m;
	my $last = pop(@tokens);
	print Dumper "Text", \@_, $last, $last_token;
	$_[0] =~ s/\n//g;
	$last->{Description} ||= "";
	$last->{Description} .= $_[0];
	if ($last->{type} eq 'a' and $last->{attrs}->{href} =~ m!^talks/(\d*)/(\d*)!) {
		my ($year, $month) = ($1, $2);
		$talks{by_date}{$year}{$month} ||= [];
		push(@{ $talks{by_date}{$year}{$month}},  { %{ $last->{attrs} } });
	}
	if ($last->{type} eq 'li' and $last_token->{type} eq 'a' and $last_token->{attrs}->{href} =~ m!^talks/(\d*)/(\d*)!) {
		my ($year, $month) = ($1, $2);
		$_[0] =~ s/\n//g;
		my $author = $_[0];
		$author =~ s/^\s*\(//;
		$author =~ s/\)\s*$//;
		my $talk = pop(@{ $talks{by_date}{$year}{$month}});
		$talk->{author} = $author;
		push(@{ $talks{by_date}{$year}{$month}},  { %{ $talk } });
		$talks{by_author}{$author}{$year}{$month} ||= [];
		push(@{ $talks{by_author}{$author}{$year}{$month}},  { %{ $talk } });
	}
	push(@tokens, $last);
}
sub start {
	print Dumper "Start", \@_;
	push @tokens, { type => $_[0],
					attrs => $_[1],
					};
}
sub end {

#	warn Dumper "end", \@_;
	$last_token = pop @tokens;
#	warn "Whoops last $last_token->{type} ne $_[0]\n" unless $last_token->{type} eq $_[0];
}

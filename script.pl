#!/usr/bin/perl -w

use warnings;
use strict;
use MediaWiki::API;
use Data::Dumper;

sub genlinks{
    my $page = shift;
    #configure API
    my $mw = MediaWiki::API->new();
    $mw->{config}->{api_url} = 'http://en.wikipedia.org/w/api.php';
    #submit query
    my $query = $mw->api( {
	action => 'query',
	titles => $page,
	prop => 'links',
	pllimit => 'max' } )
	|| die $mw->{error}->{code} . ': ' . $mw->{error}->{details};
    #create array with hashrefs from query return
    my ($ns, $links) = each ( %{ $query->{query}->{pages} } ); 
    my @hashrefs = @{ $links->{'links'} };
   
    my @linklist;
    my $i = 0;
    foreach (@hashrefs){
	my %hash = %$_;
	$linklist[$i] = $hash{title};
	$i++;
    }
    my $linkref = \@linklist;
    return $linkref;
}

print "What page would you like to list the links for?\n";
my $page=<STDIN>; chomp $page;

my $listref = genlinks($page);
my @list = @$listref;
foreach (@list){print $_, "\n";}

#!/usr/bin/perl -w

use MediaWiki::API;

my $mw = MediaWiki::API->new();
$mw->{config}->{api_url} = 'http://en.wikipedia.org/w/api.php';

my $titles = $mw->api( {
    action => 'query',
    titles => 'Albert Einstein',
    prop => 'links',
    pllimit => 'max'} )
    || die $mw->{error}->{code} . ': ' . $mw->{error}->{details};

my ($ns,$links) = each ( %{ $titles->{query}->{pages} } );
print "success!\n";

#creates array of hash references
my @hashrefs = @{  $links->{'links'} }; ;

foreach (@hashrefs){
    #$_ is hashref
    my %hash = %$_;
    print $hash{title}, "\n";
}



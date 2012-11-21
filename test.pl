#!/usr/bin/perl -w

use MediaWiki::API;

my $mw = MediaWiki::API->new();
$mw->{config}->{api_url} = 'http://en.wikipedia.org/w/api.php';

my $titles = $mw->api( {
    action => 'query',
    titles => 'Mark Twain',
    prop => 'langlinks',} )
    || die $mw->{error}->{code} . ': ' . $mw->{error}->{details};

my ($pageid,$langlinks) = each ( %{ $titles->{query}->{pages} } );

print "success!\n";

foreach ( @{ $langlinks->{langlinks} } ) {
   print "$_->{'*'}\n";
}



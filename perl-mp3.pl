#!/usr/bin/perl
use strict;
use warnings;
use LWP::Simple;
use URI;


print "Enter the URL of the MP3 file: ";
my $url = <STDIN>;
chomp($url);


my $uri = URI->new($url);
if (!$uri->scheme || $uri->scheme !~ /^https?$/ || !$uri->host) {
    die "Invalid URL.\n";
}


my $filename = (split '/', $uri->path)[-1];
if (!$filename) {
    die "Could not determine the filename from the URL.\n";
}


print "Downloading $filename...\n";
my $status = getstore($url, $filename);

if (is_success($status)) {
    print "Download completed: $filename\n";
} else {
    print "Failed to download the file. Status code: $status\n";
}

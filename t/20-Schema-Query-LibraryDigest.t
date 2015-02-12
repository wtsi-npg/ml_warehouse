use strict;
use warnings;
use YAML qw/ LoadFile /;
use Test::More tests => 3;
use Test::Exception;

use_ok('WTSI::DNAP::Warehouse::Schema');
use_ok('WTSI::DNAP::Warehouse::Schema::Query::LibraryDigest');

sub _load_fixtures {
    my ($schema, $path) = @_;

    opendir my $dh, $path or die "Could not open $path";
    my @fixtures = sort grep { /[.]yml$/smix } readdir $dh;
    closedir $dh;
    if (scalar @fixtures == 0) { die qq[no fixtures found at $path]; }

    for my $fx (@fixtures) {
        my $yml  = LoadFile("$path/$fx");
        my @temp = split m/[._]/sxm, $fx;
        pop @temp;
        my $table = join q[.], @temp;
        $table =~ s/^(\d)+-//smx;
        warn "+- Loading $fx into $table\n";
        my $rs = $schema->resultset($table);
        foreach my $row (@{$yml}) {
           $rs->create($row);
        }
    }
    return;
}

my $schema;
lives_ok { 
  $schema = WTSI::DNAP::Warehouse::Schema->connect('dbi:SQLite:dbname=:memory:');
  $schema->deploy();
  #_load_fixtures($schema, 't/data/fixtures');
} 'created in-memory test database';

1;
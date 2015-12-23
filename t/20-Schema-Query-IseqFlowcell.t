use strict;
use warnings;
use Test::More tests => 14;
use Test::Exception;
use Test::Warn;
use YAML qw/ LoadFile /;
use DateTime;
use DateTime::Duration;
use DateTime::Format::SQLite;
use Moose::Util qw/ apply_all_roles /;
use Moose::Meta::Class;

use_ok('WTSI::DNAP::Warehouse::Schema');
use_ok('WTSI::DNAP::Warehouse::Schema::Result::IseqFlowcell');

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
  _load_fixtures($schema, 't/data/fixtures');
} 'created in-memory test database';

my $products = $schema->resultset('IseqProductMetric');
my $flowcells = $schema->resultset('IseqFlowcell');

{
  my $anonclass;
  throws_ok {
    $anonclass = Moose::Meta::Class->create_anon_class(
      roles        => [qw/WTSI::DNAP::Warehouse::Schema::Query::IseqFlowcell/],
    );
  } qr/requires the method.* 'iseq_flowcell' to be implemented/sm, 'Cannot create anonymous class with Query::IseqFlowcell role without iseq_flowcell';

  throws_ok {
    $anonclass = Moose::Meta::Class->create_anon_class();
    $anonclass->add_attribute('iseq_flowcell' => {is => 'ro', isa => 'DBIx::Class::ResultSet'});
    apply_all_roles($anonclass, qw/WTSI::DNAP::Warehouse::Schema::Query::IseqFlowcell/);
  } qr/requires the methods 'flowcell_barcode'.* 'id_flowcell_lims'.* to be implemented/sm, 'Cannot create anonymous class with Query::IseqFlowcell role without flowcell_barcode or id_flowcell_lims';

  lives_ok {
    $anonclass = Moose::Meta::Class->create_anon_class();
    $anonclass->add_attribute('iseq_flowcell' => {is => 'ro', isa => 'DBIx::Class::ResultSet'});
    $anonclass->add_attribute('flowcell_barcode' => {is => 'ro', isa => 'Str'});
    $anonclass->add_attribute('id_flowcell_lims' => {is => 'ro', isa => 'Str'});
    apply_all_roles($anonclass, qw/WTSI::DNAP::Warehouse::Schema::Query::IseqFlowcell/);
  } 'Create anonymous class with Query::IseqFlowcell role with default Query::IseqFlowcell role';
  my $obj;
  lives_ok { $obj = $anonclass->new_object(iseq_flowcell=>$schema->resultset('IseqFlowcell'), flowcell_barcode=>'HBF2DADXX'); } 'generate object from flowcell barcode';
  is($obj->query_resultset->count, 10, 'result count');
  warning_like { $anonclass->new_object(iseq_flowcell=>$schema->resultset('IseqFlowcell'), flowcell_barcode=>'HBF2DADXX_wrong', id_flowcell_lims=>34769 )->query_resultset; } qr/\QDeclared flowcell_barcode HBF2DADXX_wrong differs from that found: HBF2DADXX\E/sm, 'warn on conflicting info';

  throws_ok {
    $anonclass = Moose::Meta::Class->create_anon_class();
    $anonclass->add_attribute('iseq_flowcell' => {is => 'ro', isa => 'DBIx::Class::ResultSet'});
    $anonclass->add_attribute('flowcell_barcode' => {is => 'ro', isa => 'Str'});
    $anonclass->add_attribute('id_flowcell_lims' => {is => 'ro', isa => 'Str'});
    apply_all_roles($anonclass, q/WTSI::DNAP::Warehouse::Schema::Query::IseqFlowcell/ => {'autonomous'=>1});
  } qr/requires the method.* 'has_id_run'.* to be implemented/sm, 'Cannot create anonymous class with Query::IseqFlowcell role autonomous option on without id_run';

  lives_ok {
    $anonclass = Moose::Meta::Class->create_anon_class();
    $anonclass->add_attribute('iseq_flowcell' => {is => 'ro', isa => 'DBIx::Class::ResultSet'});
    $anonclass->add_attribute('flowcell_barcode' => {is => 'ro', isa => 'Str'});
    $anonclass->add_attribute('id_flowcell_lims' => {is => 'ro', isa => 'Str'});
    $anonclass->add_attribute('id_run' => {is => 'ro', isa => 'Int', lazy_build => 1});
    apply_all_roles($anonclass, q/WTSI::DNAP::Warehouse::Schema::Query::IseqFlowcell/ => {'autonomous'=>1});
  } 'Create anonymous class with Query::IseqFlowcell role autonomous option on';
  lives_ok { $obj = $anonclass->new_object(iseq_flowcell=>$schema->resultset('IseqFlowcell'), id_run=>15440,); } 'generate object from id_run';
  is($obj->query_resultset->count, 10, 'result count');
  warning_like { $anonclass->new_object(iseq_flowcell=>$schema->resultset('IseqFlowcell'), flowcell_barcode=>'HBF2DADXX_wrong', id_run=>15440)->query_resultset; } qr/\QDeclared flowcell_barcode HBF2DADXX_wrong differs from that found: HBF2DADXX\E/sm, 'warn on conflicting info';

};

1;

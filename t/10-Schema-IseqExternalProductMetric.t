use strict;
use warnings;
use Test::More tests => 8;
use Test::Exception;
use Test::Warn;
use English qw(-no_match_vars);

use_ok('WTSI::DNAP::Warehouse::Schema');

my $schema;
lives_ok { $schema = WTSI::DNAP::Warehouse::Schema->connect('dbi:SQLite:dbname=:memory:') }
  'connected to test in-memory database';
lives_ok { $schema->deploy() } 'schema deployed';

my $rs   = $schema->resultset('IseqExternalProductMetric');
my $rsp  = $schema->resultset('IseqProductMetric');
my $rspc = $schema->resultset('IseqProductComponent');

($rs->search({})->count() == 0) or die 'external product table is not empty';
($rsp->search({id_run => 4950})->count() == 0) or die
  'product table should not contain rows for run 4950';

my $composition_modules_available = 0;

eval {
  require npg_tracking::glossary::composition;
  require npg_tracking::glossary::composition::component::illumina;
  $composition_modules_available = 1;
};

sub _create_product {
  my ($data, $positions) = @_;

  my $prow = $rsp->create($data);
  my @single_component_rows = ();
  for my $p (@{$positions}) {
    my $cdata = {
      id_run    => $data->{id_run},
      position  => $p,
      tag_index => $data->{tag_index}
    };
    my $c = npg_tracking::glossary::composition->new(
      components => [npg_tracking::glossary::composition::component::illumina->new($cdata)]
    );
    $cdata->{id_iseq_product} = $c->digest;
    $cdata->{iseq_composition_tmp} = $c->freeze;
    push @single_component_rows, $rsp->create($cdata);
  }
  if (not @single_component_rows) {
    push @single_component_rows, $prow; # will link on itself
  }
 
  my $num_components = scalar @single_component_rows;
  my $index = 1;
  for my $sc_product (@single_component_rows) {
    $rspc->create({
      num_components           => $num_components,
      component_index          => $index,
      id_iseq_pr_tmp           => $prow->id_iseq_pr_metrics_tmp,
      id_iseq_pr_component_tmp => $sc_product->id_iseq_pr_metrics_tmp
    });
    $index++;
  }

  return;
}

SKIP: {
      skip 'npg_tracking::glossary::composition module not available',
           4 unless $composition_modules_available;

subtest 'insert, single file name' => sub {
  plan tests => 14;

  my $row;
  warning_like { $row = $rs->create({file_name => '4950_5#5.bam',
                                     file_path => 'some/4950_5#5.bam'}) }
    [qr/Not a recognised file name/], 'error captured';
  ok (!$row->id_run, '4950_5#5.bam id_run not set');
  ok (!$row->id_iseq_product, '4950_5#5.bam product id not set');
  ok (!$row->iseq_composition_tmp, '4950_5#5.bam product JSON not set');

  $row = $rs->create({file_name => '4950_5#6.cram',
                      file_path => 'some/4950_5#6.cram'});
  is ($row->id_run, 4950, '4950_5#6.cram id_run not set');
  is ($row->id_iseq_product,
    '616e4f2191c5c80c7f94b3e58a980c5e6118fa132da1d05f400da2bdd4bfff48',
    '4950_5#6.cram product id not set');
  is ($row->iseq_composition_tmp,
    '{"components":[{"id_run":4950,"position":5,"tag_index":6}]}',
    '4950_5#6.cram product JSON not set');

  warning_like { $row = $rs->create({file_name => '4950#7.cram',
                                     file_path => 'some/4950#7.cram'}) }
      [qr/No existing merged product found/], 'error captured';
  ok (!$row->id_run, 'id_run not set');
  ok (!$row->id_iseq_product, 'product id not set');
  ok (!$row->iseq_composition_tmp, 'product JSON not set');

  my $json = '{"components":[{"id_run":4950,"position":2,"tag_index":8},{"id_run":4950,"position":3,"tag_index":8},{"id_run":4950,"position":4,"tag_index":8}]}';
  my $id = npg_tracking::glossary::composition->thaw(
    $json,
    component_class => 'npg_tracking::glossary::composition::component::illumina'
  )->digest;
  _create_product({
    id_run               => 4950,
    tag_index            => 8,
    id_iseq_product      => $id,
    iseq_composition_tmp => $json
  }, [2,3,4]);

  $row = $rs->create({file_name => '4950#8.cram',
                      file_path => 'some/4950#8.cram'});
  is ($row->id_run, 4950, '4950#8.cram run id is set');
  is ($row->id_iseq_product, $id, '4950#8.cram product id is set');
  is ($row->iseq_composition_tmp, $json, '4950#8.cram product JSON is set');
};

subtest 'insert, multiple file names' => sub {
  plan tests => 7;

  my $row;
  warning_like { $row = $rs->create({file_name => '4950#5.cram,4950_3#5.cram',
                                     file_path => 'some/4950#5.cram, other/4950_3#5.cram'}) }
    [qr/No existing merged product found/], 'error captured';
  ok (!$row->id_run, 'id_run not set');
  ok (!$row->id_iseq_product, 'product id not set');
  ok (!$row->iseq_composition_tmp, 'product JSON not set');

  $row = $rs->create({file_name => '4950_5#6.cram,4950#8.cram',
                      file_path => 'some/4950_5#6.cram, some/4950#8.cram'});
  ok (!$row->id_run, 'run id is not set');
  is ($row->id_iseq_product,
    'd18127bfc5c360fe1e9dcdce33f9fe4cded9826b1e3d398c40717b8d61134ace', 'product id is set');
  is ($row->iseq_composition_tmp,
    '{"components":[{"id_run":4950,"position":2,"tag_index":8},{"id_run":4950,"position":3,"tag_index":8},{"id_run":4950,"position":4,"tag_index":8},{"id_run":4950,"position":5,"tag_index":6}]}',
    'product JSON is set');
};

subtest 'update, single file name' => sub {
  plan tests => 9;

  my $row = $rs->search({file_path => 'some/4950_5#6.cram'})->next;
  my $timestamp = $row->last_changed();
  sleep 1;
  $row->update({file_name => '1236#7.cram'}); # nothing to update
  ok ($row->last_changed() eq $timestamp,
    'row not updated where metadata were present prior to an update');

  $row = $rs->search({file_path => 'some/4950_5#5.bam'})->next;
  warning_like { $row->update({file_name => '4950_5#5.cram', file_path => 'some/4950_5#5.cram'}) }
    [qr/Not a recognised file name/], 'error captured';
  ok (!$row->id_iseq_product, 'product id is not set');

  $row->update({file_name => '4950_5#5.cram'}); # nothing to update
  is ($row->id_run, 4950, 'run id is set');
  is ($row->id_iseq_product,
    '34785cdb4f58d5ccc368eda699cd3450d3eb63f5f341d8e008811e626399d688', 'product id is set');
  is ($row->iseq_composition_tmp,
    '{"components":[{"id_run":4950,"position":5,"tag_index":5}]}', 'product JSON is set');

  my $json = '{"components":[{"id_run":4950,"position":1,"tag_index":7},{"id_run":4950,"position":3,"tag_index":7},{"id_run":4950,"position":4,"tag_index":7}]}';
  my $id = npg_tracking::glossary::composition->thaw(
    $json,
    component_class => 'npg_tracking::glossary::composition::component::illumina'
  )->digest;
  _create_product({
    id_run               => 4950,
    tag_index            => 7,
    id_iseq_product      => $id,
    iseq_composition_tmp => $json
  }, [1,3,4]);

  $row = $rs->search({file_path => 'some/4950#7.cram'})->next;
  $row->update({manifest_upload_status => 'SUCCESS'});
  is ($row->id_run, 4950, 'run id is set');
  is ($row->id_iseq_product, $id, 'product id is set');
  is ($row->iseq_composition_tmp, $json, 'product JSON is set');
};

subtest 'update, multiple file names' => sub {
  plan tests => 7;

  my $row = $rs->search({file_path => 'some/4950#5.cram, other/4950_3#5.cram'})->next;
  warning_like { $row->update({manifest_upload_status => 'FAILED'}) }
    [qr/No existing merged product found/], 'error captured';
  ok (!$row->id_run, 'run id is not set');
  ok (!$row->id_iseq_product, 'product id is not set');
  ok (!$row->iseq_composition_tmp, 'product JSON is set');

  my $json = '{"components":[{"id_run":4950,"position":1,"tag_index":5},{"id_run":4950,"position":2,"tag_index":5}]}';
  my $id = npg_tracking::glossary::composition->thaw(
    $json,
    component_class => 'npg_tracking::glossary::composition::component::illumina'
  )->digest;
  _create_product({
    id_run               => 4950,
    tag_index            => 5,
    id_iseq_product      => $id,
    iseq_composition_tmp => $json
  }, [1,2]);

  $json = '{"components":[{"id_run":4950,"position":1,"tag_index":5},{"id_run":4950,"position":2,"tag_index":5},{"id_run":4950,"position":3,"tag_index":5}]}';
  $row->update({manifest_upload_status => 'SUCCESS'});
  ok (!$row->id_run, 'run id is not set');
  is ($row->id_iseq_product,
    '0a0250691b5a601b8b36b892d81c84b9e93691ee6fec08822e5d2bf6e40fb5ac', 'product id is set');
  is ($row->iseq_composition_tmp, $json, 'product JSON is set');
};

}; # END of SKIP for  ($composition_modules_available == 0)

SKIP: {
      skip 'npg_tracking::glossary::composition module is available',
           1 unless (not $composition_modules_available);

subtest 'default behaviour when compositions modules not available' => sub {
  plan tests => 6;

  my $row;
  warning_like { $row = $rs->create({file_name => '4950#1.cram',
                                     file_path => 'some/4950#1.cram'}) }
    [qr/Can't locate/], 'can insert, error captured';
  ok ($row, 'row created');
  is ($row->file_name, '4950#1.cram', 'file name for the row');

  ok (!$row->manifest_upload_status, 'status not set');
  warning_like { $row->update({manifest_upload_status => 'SUCCESS'}) }
    [qr/Can't locate/], 'can update, error captured';
  is ($row->manifest_upload_status, 'SUCCESS', 'row updated');
};

}; # END of SKIP for  ($composition_modules_available == 1);

1;


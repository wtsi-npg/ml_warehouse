use strict;
use warnings;
use Test::More tests => 9;
use Test::Exception;
use Test::Warn;
use English qw(-no_match_vars);

use_ok('WTSI::DNAP::Warehouse::Schema');

my $schema;
lives_ok { $schema = WTSI::DNAP::Warehouse::Schema->connect('dbi:SQLite:dbname=:memory:') }
  'connected to test in-memory database';
lives_ok { $schema->deploy() } 'schema deployed';

my $rs    = $schema->resultset('IseqExternalProductMetric');
my $rsp   = $schema->resultset('IseqProductMetric');
my $rspc  = $schema->resultset('IseqProductComponent');
my $rsepc = $schema->resultset('IseqExternalProductComponent');

($rs->search({})->count() == 0) or die 'external product table is not empty';
($rsepc->search({})->count() == 0) or die 'external product component table is not empty';
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
    push @single_component_rows, $rsp->update_or_create($cdata);
  }
  if (not @single_component_rows) {
    push @single_component_rows, $prow; # will link on itself
  }
 
  my $num_components = scalar @single_component_rows;
  my $index = 1;
  for my $sc_product (@single_component_rows) {
    $rspc->update_or_create({
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
           5 unless $composition_modules_available;

subtest 'insert, single file name' => sub {
  plan tests => 33;

  my $row;
  warning_like { $row = $rs->create({file_name => '4950_5#5.bam',
                                     file_path => 'some/4950_5#5.bam'}) }
    [qr/Not a recognised file name/], 'error captured';
  ok (!$row->id_run, '4950_5#5.bam id_run not set');
  ok (!$row->id_iseq_product, '4950_5#5.bam product id not set');
  ok (!$row->iseq_composition_tmp, '4950_5#5.bam product JSON not set');
  ok (!$rsepc->search({})->count(), 'no rows added to a linking table');

  $row = $rs->create({file_name => '4950_5#6.cram',
                      file_path => 'some/4950_5#6.cram'});
  is ($row->id_run, 4950, '4950_5#6.cram id_run is set');
  my $digest = '616e4f2191c5c80c7f94b3e58a980c5e6118fa132da1d05f400da2bdd4bfff48';
  is ($row->id_iseq_product, $digest, '4950_5#6.cram product id is set');
  is ($row->iseq_composition_tmp,
    '{"components":[{"id_run":4950,"position":5,"tag_index":6}]}',
    '4950_5#6.cram product JSON is set');
  my $linking_rs = $rsepc->search({});
  is ($linking_rs->count(), 1, 'one linking row created');
  $row = $linking_rs->next;
  is ($row->num_components, 1, 'number of components - 1');
  is ($row->component_index, 1, 'component index - 1');
  ok (($row->id_iseq_product_ext eq $digest) &&
      ($row->id_iseq_product eq $digest), 'record is correctly linked');
  my $first_lr_id = $row->id_iseq_ext_pr_components_tmp;

  warning_like { $row = $rs->create({file_name => '4950#7.cram',
                                     file_path => 'some/4950#7.cram'}) }
      [qr/No existing merged product found/], 'error captured';
  ok (!$row->id_run, 'id_run not set');
  ok (!$row->id_iseq_product, 'product id not set');
  ok (!$row->iseq_composition_tmp, 'product JSON not set');
  is ($rsepc->search({})->count(), 1, 'no new linking rows created');

  my $json = '{"components":[{"id_run":4950,"position":2,"tag_index":8},{"id_run":4950,"position":3,"tag_index":8},{"id_run":4950,"position":8,"tag_index":8}]}';
  $digest = npg_tracking::glossary::composition->thaw(
    $json,
    component_class => 'npg_tracking::glossary::composition::component::illumina'
  )->digest;
  _create_product({
    id_run               => 4950,
    tag_index            => 8,
    id_iseq_product      => $digest,
    iseq_composition_tmp => $json
  }, [2,3,8]);

  $row = $rs->create({file_name => '4950#8.cram',
                      file_path => 'some/4950#8.cram'});
  is ($row->id_run, 4950, '4950#8.cram run id is set');
  is ($row->id_iseq_product, $digest, '4950#8.cram product id is set');
  is ($row->iseq_composition_tmp, $json, '4950#8.cram product JSON is set');
  $linking_rs = $rsepc->search({});

  is ($linking_rs->count(), 4, 'three new linking rows created');
  my @rows = grep { $_->id_iseq_ext_pr_components_tmp != $first_lr_id }
             $linking_rs->all();
  my $i = 1;
  my @ids = qw/
    19aee97bfa4a10795c3e7cd660c6502e7034e8286737d8479b9e005225921356
    54faaedd149083b59ab430c56ef145c63fb0f85e4b38c65fb0c256475f1b2ae3
    a61ebd9c90f81b8f3e29322ec7980ff74111532ecc051e456eff2d0e9700a8b6
  /;
  for my $r (@rows) {
    is ($r->num_components, 3, 'number of components - 3');
    is ($r->component_index, $i, "component index - $i");
    is ($r->id_iseq_product_ext, $digest, 'linked to the external product');
    is ($r->id_iseq_product, $ids[$i-1], 'linked to wsi single product');
    $i++;
  }
};

subtest 'insert, multiple file names' => sub {
  plan tests => 21;

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
  my $digest = 'd4d6f63965c33c030809b635ad07f9b712cf4db0c750a5d7edb878728daaa308';
  is ($row->id_iseq_product, $digest, 'product id is set');
  is ($row->iseq_composition_tmp,
    '{"components":[{"id_run":4950,"position":2,"tag_index":8},{"id_run":4950,"position":3,"tag_index":8},{"id_run":4950,"position":5,"tag_index":6},{"id_run":4950,"position":8,"tag_index":8}]}',
    'product JSON is set');

  my $linking_rs = $rsepc->search({});
  is ($linking_rs->count(), 8, 'four new linking rows created');
  my @rows = grep { $_->num_components == 4 }
             $linking_rs->all();
  is (@rows, 4, 'four linking rows are for 4-component composition');
  my $i = 1;
  my @ids = qw/
    19aee97bfa4a10795c3e7cd660c6502e7034e8286737d8479b9e005225921356
    54faaedd149083b59ab430c56ef145c63fb0f85e4b38c65fb0c256475f1b2ae3
    616e4f2191c5c80c7f94b3e58a980c5e6118fa132da1d05f400da2bdd4bfff48
    a61ebd9c90f81b8f3e29322ec7980ff74111532ecc051e456eff2d0e9700a8b6
  /;
  for my $r (@rows) {
    is ($r->component_index, $i, "component index - $i");
    is ($r->id_iseq_product_ext, $digest, 'linked to the external product');
    is ($r->id_iseq_product, $ids[$i-1], 'linked to wsi single product');
    $i++;
  }
};

subtest 'update, single file name' => sub {
  plan tests => 28;

  my $lcount = $rsepc->search({})->count();

  my $row = $rs->search({file_path => 'some/4950_5#6.cram'})->next;
  my $timestamp = $row->last_changed();
  sleep 1;
  $row->update({file_name => '1236#7.cram'}); # nothing to update
  ok ($row->last_changed() eq $timestamp,
    'row not updated where metadata were present prior to an update');
  is ($rsepc->search({})->count(), $lcount, 'no new linking rows created');

  $row = $rs->search({file_path => 'some/4950_5#5.bam'})->next;
  warning_like { $row->update({file_name => '4950_5#5.cram', file_path => 'some/4950_5#5.cram'}) }
    [qr/Not a recognised file name/], 'error captured';
  ok (!$row->id_iseq_product, 'product id is not set');
  is ($rsepc->search({})->count(), $lcount, 'no new linking rows created');

  $row->update({file_name => '4950_5#5.cram'}); # nothing to update
  my $digest = '34785cdb4f58d5ccc368eda699cd3450d3eb63f5f341d8e008811e626399d688';
  is ($row->id_run, 4950, 'run id is set');
  is ($row->id_iseq_product, $digest, 'product id is set');
  is ($row->iseq_composition_tmp,
    '{"components":[{"id_run":4950,"position":5,"tag_index":5}]}', 'product JSON is set');

  $lcount++;
  my $linking_rs = $rsepc->search({},
     {order_by => {-desc => 'id_iseq_ext_pr_components_tmp'}});
  is ($linking_rs->count(), $lcount, 'one linking row created');
  $row = $linking_rs->next;
  is ($row->component_index, 1, 'component index - 1');
  is ($row->num_components, 1, 'number of components - 1');
  ok (($row->id_iseq_product_ext eq $digest) &&
      ($row->id_iseq_product eq $digest), 'record is correctly linked');

  my $json = '{"components":[{"id_run":4950,"position":1,"tag_index":7},{"id_run":4950,"position":3,"tag_index":7},{"id_run":4950,"position":5,"tag_index":7}]}';
  $digest = npg_tracking::glossary::composition->thaw(
    $json,
    component_class => 'npg_tracking::glossary::composition::component::illumina'
  )->digest;
  _create_product({
    id_run               => 4950,
    tag_index            => 7,
    id_iseq_product      => $digest,
    iseq_composition_tmp => $json
  }, [1,3,5]);

  $row = $rs->search({file_path => 'some/4950#7.cram'})->next;
  $row->update({manifest_upload_status => 'SUCCESS'});
  is ($row->id_run, 4950, 'run id is set');
  is ($row->id_iseq_product, $digest, 'product id is set');
  is ($row->iseq_composition_tmp, $json, 'product JSON is set');

  my $num_links = 3;
  $lcount += $num_links;
  $linking_rs = $rsepc->search({},
    {order_by => {-desc => 'id_iseq_ext_pr_components_tmp'}});
  is ($linking_rs->count(), $lcount, "$num_links linking rows created");
  my @digests = qw/
    4c9f23dc3ca78ef5c3a7ad91be3e0a18744ab3f3639fb86093580a6809bad939
    2743b242f90a4d1929793764107742363e0db15458e417dcdb6b0a7c17cc01df
    87d0434587bfcd7e8a732695505d1c6cd3ed61ea86395aa0f38b4ee7bf362b35 
  /;
  while ($num_links > 0) {
    $row = $linking_rs->next;
    is ($row->component_index, $num_links, "component index - $num_links");
    is ($row->num_components, 3, 'number of components - 3');
    is ($row->id_iseq_product_ext, $digest, 'link to the external product row');
    is ($row->id_iseq_product, $digests[$num_links-1],
      'link to the wsi product row');
    $num_links--;
  }
};

subtest 'update, multiple file names' => sub {
  plan tests => 7;

  my $row = $rs->search({file_path => 'some/4950#5.cram, other/4950_3#5.cram'})->next;
  warning_like { $row->update({manifest_upload_status => 'FAILED'}) }
    [qr/No existing merged product found/], 'error captured';
  ok (!$row->id_run, 'run id is not set');
  ok (!$row->id_iseq_product, 'product id is not set');
  ok (!$row->iseq_composition_tmp, 'product JSON is not set');

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

subtest 'insert, partial lane merge' => sub {
  plan tests => 8;

  my $json = '{"components":[{"id_run":49890,"position":1,"tag_index":8},' . 
            '{"id_run":49890,"position":2,"tag_index":8},' .
            '{"id_run":49890,"position":3,"tag_index":8},' .
            '{"id_run":49890,"position":4,"tag_index":8}]}';

  my $digest = npg_tracking::glossary::composition->thaw(
    $json,
    component_class =>
      'npg_tracking::glossary::composition::component::illumina'
  )->digest;
  _create_product({
    id_run               => 49890,
    tag_index            => 8,
    id_iseq_product      => $digest,
    iseq_composition_tmp => $json
  }, [1,2,3,4]);

  my $json_3m =   '{"components":[' . 
            '{"id_run":49890,"position":2,"tag_index":8},' .
            '{"id_run":49890,"position":3,"tag_index":8},' .
            '{"id_run":49890,"position":4,"tag_index":8}]}';
  my $digest_3m = npg_tracking::glossary::composition->thaw(
    $json_3m,
    component_class =>
      'npg_tracking::glossary::composition::component::illumina'
  )->digest;
  _create_product({
    id_run               => 49890,
    tag_index            => 8,
    id_iseq_product      => $digest_3m,
    iseq_composition_tmp => $json_3m
  }, [2,3,4]); # partial merge of three lanes

  my $json_2m =   '{"components":[' . 
            '{"id_run":49890,"position":1,"tag_index":8},' .
            '{"id_run":49890,"position":3,"tag_index":8}]}';
  my $digest_2m = npg_tracking::glossary::composition->thaw(
    $json_2m,
    component_class =>
      'npg_tracking::glossary::composition::component::illumina'
  )->digest;
  _create_product({
    id_run               => 49890,
    tag_index            => 8,
    id_iseq_product      => $digest_2m,
    iseq_composition_tmp => $json_2m
  }, [1,3]); # partial merge of two lanes

  my $linking_rs = $rsepc->search({});
  my $lr_count = $linking_rs->count(); # initial count of linking rows

  my $row = $rs->create({file_name => '49890_1-3#8.cram',
                         file_path => 'some/49890_1-3#8.cram'});
  is ($row->id_run, 49890, '49890_1-3#8.cram run id is set');
  is ($row->id_iseq_product, $digest_2m, '49890_1-3#8.cram product id is set');
  is ($row->iseq_composition_tmp, $json_2m, 'product JSON is set');
  $linking_rs = $rsepc->search({});
  is ($linking_rs->count(), $lr_count+2, 'two new linking rows created');
  
  $row = $rs->create({file_name => '49890_2-3-4#8.cram',
                      file_path => 'some/49890_2-3-4#8.cram'});
  is ($row->id_run, 49890, '49890_2-3-4#8.cram run id is set');
  is ($row->id_iseq_product, $digest_3m, 'product id is set');
  is ($row->iseq_composition_tmp, $json_3m, 'product JSON is set');
  $linking_rs = $rsepc->search({});
  is ($linking_rs->count(), $lr_count+5, 'three new linking rows created');
};

}; # END of SKIP for  ($composition_modules_available == 0)

SKIP: {
      skip 'npg_tracking::glossary::composition module is available',
           1 unless (not $composition_modules_available);

subtest 'default behaviour when compositions modules not available' => sub {
  plan tests => 7;

  my $count = $rsepc->search({})->count();

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
  is ($rsepc->search({})->count(), $count, 'no new linking rows created');
};

}; # END of SKIP for  ($composition_modules_available == 1);

1;


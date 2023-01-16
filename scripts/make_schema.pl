#!/usr/bin/env perl

use strict;
use warnings;
use Carp;
use Config::Auto;
use Readonly;
use DBIx::Class::Schema::Loader qw(make_schema_at);

Readonly::Scalar our $NPG_CONF_DIR   => q[.npg];
Readonly::Scalar our $CONF_FILE_NAME => q[WTSI-DNAP-Warehouse-Schema];

my $domain = $ENV{dev} || q[live];
my $schema_class_name = q[WTSI::DNAP::Warehouse::Schema];

carp qq[SCHEMA CLASS NAME $schema_class_name, DOMAIN $domain];

my $path = join q[/], $ENV{'HOME'}, $NPG_CONF_DIR, $CONF_FILE_NAME;
my $config = Config::Auto::parse($path);
if (defined $config->{$domain}) {
  $config = $config->{$domain};
}

make_schema_at(
  $schema_class_name,
  {
    debug              => 0, 
    dump_directory     => q[lib], 
    naming             => q[current],
    components         => [qw(InflateColumn::DateTime)],
    skip_load_external => 1,
    use_moose          => 1,
    exclude            => qr/cherrypicked_sample|heron_product_metrics_view/,
    rel_name_map       => sub {
          my %h=%{shift@_};
          my $name=$h{'name'};
          $name=~s/^id_//;
          $name=~s/_tmp$//;
          $name=~s/_tmps$/s/;
          $name=~s/_tmps$/s/;
          $name=~s/^iseq_product_components_id_//;
          if ($name !~ /product/) {$name =~ s/iseq_pr/iseq_product/};
          return $name;
    },
    filter_generated_code => sub {
          my ($type, $class, $code) = @_;
          $code =~ s/use\ utf8;//;
          if ($type eq 'result') {
            $code =~ tr/"/'/;
          }
          return $code;
    },
  }, 
  [$config->{'dsn'}, $config->{'dbuser'}, $config->{'dbpass'}]
              );

1;

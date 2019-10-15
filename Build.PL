use strict;
use warnings;
use WTSI::DNAP::Utilities::Build;

my $builder = WTSI::DNAP::Utilities::Build->new(

  'module_name'   => 'ml_warehouse',
  'dist_author'   => 'NPG team at WTSI <npg@sanger.ac.uk>',
  'dist_version'  => WTSI::DNAP::Utilities::Build->report_version,
  'dist_abstract' => 'DBIx binding for a multi-LIMs warehouse',
  'license'       => 'gpl',

  configure_requires => {
    'Module::Build'            => ">= 0.42"
  },

  'build_requires' => {
    'DateTime::Format::SQLite' => 0,
    'English'                  => 0,
    'File::Temp'               => 0,
    'File::Spec::Functions'    => 0,
    'SQL::Translator'          => 0,
    'Test::Distribution'       => 0,
    'Test::Exception'          => 0,
    'Test::More'               => 0,
    'Test::Perl::Critic'       => 0,
    'Test::Pod'                => 0,
    'YAML'                     => 0,
    'WTSI::DNAP::Utilities'    => '>= 0.5.1',
  },

  'requires' => {
    'Carp'                                 => 0,
    'Class::Load'                          => 0,
    'DBIx::Class::Core'                    => 0,
    'DBIx::Class::InflateColumn::DateTime' => 0,
    'DBIx::Class::Schema'                  => 0,
    'List::MoreUtils'                      => 0,
    'Moose'                                => 0,
    'MooseX::StrictConstructor'            => 0,
    'Moose::Role'                          => 0,
    'MooseX::Aliases'                      => 0,
    'MooseX::MarkAsMethods'                => 0,
    'MooseX::NonMoose'                     => 0,
    'MooseX::Role::Parameterized'          => 0,
    'Readonly'                             => 0,
    'strict'                               => 0,
    'Try::Tiny'                            => 0,
    'warnings'                             => 0,
  },

  'recommends' => {
    'Config::Auto'                => 0,
    'DBIx::Class::Schema::Loader' => 0,
    'npg_tracking::util::db_connect' => 0,
    'npg_qc::autoqc::role::rpt_key'  => 0,
    'npg_tracking::glossary::composition' => 0,
    'npg_tracking::glossary::composition::factory' => 0,
    'npg_tracking::glossary::composition::component::illumina' => 0
  },
);

$builder->create_build_script();

1;

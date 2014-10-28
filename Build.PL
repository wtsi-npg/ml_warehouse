use strict;
use warnings;
use Module::Build;

my $class = Module::Build->subclass(code => <<'EOF');

  sub git_tag {
    my $gitver = q[git describe --dirty --always];
    my $version = `$gitver` || 'unknown';
    $version =~ s/\s$//smxg;
    $version=~s/\A(?![\d])/0.0-/smx; #prepend 0.0- if does not start with a number
    return $version;
  }

  sub ACTION_code {
    my $self = shift;
    $self->SUPER::ACTION_code;
    my $gitver = $self->git_tag();
    my @files = split q[\n], `find blib/lib -type f -name "*.pm"`;
    if (-d 'blib/script') {
      push @files, split q[\n], `find blib/script -type f`;
    }
    foreach my $file (@files) {
      warn "Changing version of $file to $gitver\n";
      my $backup = '.original';
      local $^I = $backup;
      local @ARGV = ($file);
      while (<>) {
        s/(\$VERSION\s*=\s*)('?\S+'?)\s*;/${1}'$gitver';/;
        print;
      }
      unlink "$file$backup";
    }
    return;
  }
EOF

my $builder = $class->new(

  'module_name'   => 'ml_warehouse',
  'dist_author'   => 'npg <npg@sanger.ac.uk>',
  'dist_version'  => $class->git_tag(),
  'dist_abstract' => 'DBIx binding for a multi-LIMs warehouse',

  'build_requires' => {
    'English'               => 0,
    'Module::Build'         => 0,
    'Test::More'            => 0,
    'Test::Perl::Critic'    => 0,
    'Test::Distribution'    => 0,
    'Test::Pod'             => 0,
  },

  'requires' => {
    'Carp'                  => 0,
    'Config::Auto'          => 0,
    'DBIx::Class::Core'     => 0,
    'DBIx::Class::InflateColumn::DateTime' => 0,
    'DBIx::Class::Schema'   => 0,
    'Moose'                 => 0,
    'MooseX::MarkAsMethods' => 0,
    'MooseX::NonMoose'      => 0,
    'Readonly'              => 0,
    'strict'                => 0,
    'warnings'              => 0,
  },

  'dist' => { COMPRESS => 'gzip', SUFFIX => 'gz', },
);

$builder->create_build_script();

1;

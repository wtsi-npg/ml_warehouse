use strict;
use warnings;
use Test::More;
use English qw(-no_match_vars);

eval {
  require Test::Pod;
};

if($EVAL_ERROR) {
  plan skip_all => 'Test::Pod required for testing POD';
} else {
  Test::Pod::all_pod_files_ok();
}

1;


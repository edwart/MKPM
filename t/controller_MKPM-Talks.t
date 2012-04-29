use strict;
use warnings;
use Test::More;


use Catalyst::Test 'MKPM';
use MKPM::Controller::MKPM::Talks;

ok( request('/mkpm/talks')->is_success, 'Request should succeed' );
done_testing();

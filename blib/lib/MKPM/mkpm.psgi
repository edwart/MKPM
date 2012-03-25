use strict;
use warnings;

use MKPM;

my $app = MKPM->apply_default_middlewares(MKPM->psgi_app);
$app;


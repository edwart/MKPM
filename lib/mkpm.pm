package mkpm;
use FindBin qw/ $Bin /;
use Dancer ':syntax';
use Data::Dumper;

our $VERSION = '0.1';

our $talks;
my $filename = dirname(dirname( $Bin )).'/mkpm/public/talks.data';
do $filename;

debug Dumper $filename, $talks;

get '/' => sub {
    template 'index', { talks => $talks };
};

get '/talks' => sub {
    template 'talks', { talks => $talks };
};
true;

package mkpm;
use Dancer ':syntax';
use Data::Dumper;

our $VERSION = '0.1';

our $talks;
do '/Users/tony/workspace/mkpm/public/talks.data';

debug Dumper $talks;

get '/' => sub {
    template 'index', { talks => $talks };
};

get '/talks' => sub {
    template 'talks', { talks => $talks };
};
true;

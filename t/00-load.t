#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'MooseX::File::ConfigDir' ) || print "Bail out!
";
}

diag( "Testing MooseX::File::ConfigDir $MooseX::File::ConfigDir::VERSION, Perl $], $^X" );

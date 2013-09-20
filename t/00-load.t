#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'MooX::File::ConfigDir' ) || print "Bail out!
";
}

diag( "Testing MooX::File::ConfigDir $MooX::File::ConfigDir::VERSION, Perl $], $^X" );

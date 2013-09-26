#!perl

use strict;
use warnings;

eval {
    require local::lib;
    #local::lib->import();
};

use FindBin qw/$Script/;

package #
  My;

use Moo;

with "MooX::File::ConfigDir";

package #
   Mine;

use Moo;

sub _build_config_identifier { $FindBin::Script }

with "MooX::File::ConfigDir";

package #
  main;

use Test::More;

my $mxfcd_ = My->new(config_identifier => $FindBin::Script);
my $_mxfcd = Mine->new();

my @supported_functions = (
                            qw(system_cfg_dir desktop_cfg_dir),
                            qw(core_cfg_dir site_cfg_dir vendor_cfg_dir),
                            qw(local_cfg_dir here_cfg_dir singleapp_cfg_dir),
			    qw(xdg_config_dirs xdg_config_home user_cfg_dir),
                          );

my $diag = Test::More->can('diag');
my $note = Test::More->can('note');

foreach my $fn (@supported_functions)
{
    my $dirs_ = $mxfcd_->$fn;
    my $_dirs = $_mxfcd->$fn;
    my $report = is_deeply( $dirs_, $_dirs, "$fn" ) ? $note : $diag;
    $report->( "$fn", explain($dirs_), explain($_dirs) );
}

done_testing();

package MooseX::File::ConfigDir;

use strict;
use warnings;

# ABSTRACT: Moose eXtension for File::ConfigDir

use namespace::autoclean;

use Moose::Role;
use File::ConfigDir ();
use MooseX::AttributeShortcuts;

has 'config_identifier' => (
                            is  => 'ro',
                            isa => 'Str|Undef',
                          );
sub _fetch_file_config_dir
{
    my ( $self, $attr ) = @_;
    my $app_name  = $self->config_identifier;
    my @app_names = $app_name ? ($app_name) : ();
    my $sub = File::ConfigDir->can($attr);
    my @dirs      = &{$sub}(@app_names);
    return \@dirs;
}

my @file_config_dir_attrs;

BEGIN {
    @file_config_dir_attrs = (
                              qw(system_cfg_dir xdg_config_dirs system_cfg_dir desktop_cfg_dir),
                              qw(core_cfg_dir site_cfg_dir vendor_cfg_dir singleapp_cfg_dir),
                              qw(local_cfg_dir locallib_cfg_dir here_cfg_dir user_cfg_dir),
                              qw(xdg_config_home config_dirs)
                            );
    eval "sub _build_$_ { \$_[0]->_fetch_file_config_dir('$_') }" for @file_config_dir_attrs;
};

has [@file_config_dir_attrs] => (
            is      => 'ro',
            isa     => 'ArrayRef[Str]',
            lazy    => 1,
            builder => 1,
          );

1;

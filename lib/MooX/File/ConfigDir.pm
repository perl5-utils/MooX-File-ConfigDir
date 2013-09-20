package MooX::File::ConfigDir;

use strict;
use warnings;

# ABSTRACT: Moo eXtension for File::ConfigDir

use namespace::autoclean;

use Moo::Role;
use File::ConfigDir ();

has 'config_identifier' => (
                            is  => 'ro',
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

my @file_config_dir_attrs = (
                              qw(system_cfg_dir xdg_config_dirs desktop_cfg_dir),
                              qw(core_cfg_dir site_cfg_dir vendor_cfg_dir singleapp_cfg_dir),
                              qw(local_cfg_dir locallib_cfg_dir here_cfg_dir user_cfg_dir),
                              qw(xdg_config_home config_dirs)
                            );

 foreach my $attr (@file_config_dir_attrs)
 {
     has $attr => (
            is      => 'ro',
            lazy    => 1,
            builder => sub { $_[0]->_fetch_file_config_dir($attr) },
          );
 }

1;

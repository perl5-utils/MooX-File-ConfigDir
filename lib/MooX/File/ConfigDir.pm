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


=head1 SYNOPSIS

    my App;

    use Moo;
    with MooX::File::ConfigDir;

    1;

    package main;

    my $app = App->new();
    $app->config_identifier('MyProject');

    my @cfgdirs = @{ $app->config_dirs };

    # install support
    my $site_cfg_dir = $app->site_cfg_dir->[0];
    my $vendor_cfg_dir = $app->site_cfg_dir->[0];


=head1 DESCRIPTION

This module is a helper for easily find configuration file locations.
Whether to use this information for find a suitable place for installing
them or looking around for finding any piece of settings, heavily depends
on the requirements.

=head1 ATTRIBUTES

=head2 config_identifier

Allows to deal with a global unique identifier passed to the functions of
L<File::ConfigDir>. Using it encapsulates configuration files from the
other ones (eg. C</etc/apache2> vs. C</etc>).

=head2 system_cfg_dir

Provides the configuration directory where configuration files of the
operating system resides. For details see L<File::ConfigDir/system_cfg_dir>.

=head2 desktop_cfg_dir

Provides the configuration directory where configuration files of the
desktop applications resides. For details see L<File::ConfigDir/desktop_cfg_dir>.

=head2 xdg_config_dirs

Alias for desktop_cfg_dir to support
L<XDG Base Directory Specification|http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html>

=head2 core_cfg_dir

Provides the configuration directory of the Perl5 core location.
For details see L<File::ConfigDir/core_cfg_dir>.

=head2 site_cfg_dir

Provides the configuration directory of the Perl5 sitelib location.
For details see L<File::ConfigDir/site_cfg_dir>.

=head2 vendor_cfg_dir

Provides the configuration directory of the Perl5 vendorlib location.
For details see L<File::ConfigDir/vendor_cfg_dir>.

=head2 singleapp_cfg_dir

Provides the configuration directory of C<$0> if it's installed as
a separate package - either a program bundle (TSM, Oracle DB) or
an independent package combination (eg. via L<pkgsrc|http://www.pkgsrc.org/>
For details see L<File::ConfigDir/singleapp_cfg_dir>.

=head2 local_cfg_dir

Returns the configuration directory for distribution independent, 3rd
party applications. For details see L<File::ConfigDir/local_cfg_dir>.

=head2 locallib_cfg_dir

Provides the configuration directory of the Perl5 L<local::lib> environment
location.  For details see L<File::ConfigDir/locallib_cfg_dir>.

=head2 here_cfg_dir

Provides the path for the C<etc> directory below the current working directory.
For details see L<File::ConfigDir/here_cfg_dir>.

=head2 user_cfg_dir

Provides the users home folder using L<File::HomeDir>.
For details see L<File::ConfigDir/user_cfg_dir>.

=head2 xdg_config_home

Returns the user configuration directory for desktop applications.
For details see L<File::ConfigDir/xdg_config_home>.

=head2 config_dirs

Tries to get all available configuration directories as described above.
Returns those who exists and are readable.
For details see L<File::ConfigDir/config_dirs>.

=cut

1;

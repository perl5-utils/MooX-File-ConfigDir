use strict;
use warnings;

use Module::Build;

my $builder = Module::Build->new(
             module_name       => 'MooX::File::ConfigDir',
             license           => 'perl',
             dist_author       => q{Jens Rehsack <rehsack@cpan.org>},
             dist_version_from => 'lib/MooX/File/ConfigDir.pm',
             build_requires    => { 'Test::More' => '0.90', },
             requires => {
                           'namespace::autoclean' => 0,
                           'Moo::Role' => '1.003000',
                           'File::ConfigDir'     => '0.006',
                         },
             add_to_cleanup => ['MooX-File-ConfigDir-*'],
             meta_merge =>
               { resources => { repository => "https://github.com/perl5-utils/MooX-File-ConfigDir", }, },
             test_files => join( ' ' => 't/*.t xt/*.t' ),
);

$builder->create_build_script();

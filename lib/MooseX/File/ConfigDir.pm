package MooseX::File::ConfigDir;

use strict;
use warnings;

use Moose::Role;
use File::ConfigDir;

has 'system_cfg_dir' => (
);

has 'machine_cfg_dir' => (
);

has 'xdg_config_dirs' => (
);

has 'desktop_cfg_dir' => (
);

has 'core_cfg_dir' => (
);

has 'site_cfg_dir' => (
);

has 'vendor_cfg_dir' => (
);

has 'singleapp_cfg_dir' => (
);

has 'local_cfg_dir' => (
);

has 'locallib_cfg_dir' => (
);

has 'here_cfg_dir' => (
);

has 'user_cfg_dir' => (
);

has 'xdg_config_home' => (
);

has 'config_dirs' => (
);


1;

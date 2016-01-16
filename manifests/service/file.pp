# Class: bacula::service::file
#
# This class contain the service configuration for bacula
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include bacula::service::file
#
class bacula::service::file {

  # bacula service configuration
  service {
    $bacula::params::service_file:
      ensure  => 'running',
      enable  => true,
      require => Package[$bacula::params::package_file];
  }
}

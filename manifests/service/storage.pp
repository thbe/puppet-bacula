# Class: bacula::service::storage
#
# This class contain the service configuration for bacula
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include bacula::service::storage
#
class bacula::service::storage {

  # bacula service configuration
  service {
    $bacula::params::service_storage:
      ensure  => 'running',
      enable  => true,
      require => Package[$bacula::params::package_storage_common];
  }
}

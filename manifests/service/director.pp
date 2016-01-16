# Class: bacula::service::director
#
# This class contain the service configuration for bacula
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include bacula::service::director
#
class bacula::service::director {

  # bacula service configuration
  service {
    $bacula::params::service_director:
      ensure  => 'running',
      enable  => true,
      require => Package[$bacula::params::package_director_common];
  }
}

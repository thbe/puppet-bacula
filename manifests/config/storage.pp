# Class: bacula::config::storage
#
# This module manages Bacula backup storage daemon
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include bacula::config::storage
#
class bacula::config::storage {

  # File descriptor configuration
  file {
    $bacula::params::config_storage:
      ensure  => file,
      mode    => '0644',
      content => template($bacula::params::config_storage_template),
      notify  => Service[$bacula::params::service_storage],
      require => Package[$bacula::params::package_storage_common];
  }
}

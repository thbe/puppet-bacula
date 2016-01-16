# Class: bacula::config::file
#
# This module manages Bacula backup file descriptor
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include bacula::config::file
#
class bacula::config::file {

  # File descriptor configuration
  file {
    $bacula::params::config_file:
      ensure  => file,
      mode    => '0644',
      content => template($bacula::params::config_file_template),
      notify  => Service[$bacula::params::service_file],
      require => Package[$bacula::params::package_file];
  }
}

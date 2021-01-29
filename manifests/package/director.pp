# Class: bacula::package::director
#
# This class contain the packages for Bacula director installation
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include bacula::package::director
#
class bacula::package::director {

  # director packages

  package { $bacula::params::package_director_common: ensure => installed; }

  package { $bacula::params::package_director_mysql: ensure => installed; }

  package { $bacula::params::package_console: ensure => installed; }

  #Failed to apply catalog:
  #Could not find dependency Package[bacula-client] for File[/etc/bacula/populate_bacula_schema.sh]
  #at /etc/puppetlabs/code/environments/production/modules/bacula/manifests/config/mysql.pp:61
  package { $bacula::params::package_file: ensure => installed; }
}

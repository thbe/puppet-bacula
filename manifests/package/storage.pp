# Class: bacula::package::storage
#
# This class contain the packages for Bacula storage daemon installation
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include bacula::package::storage
#
class bacula::package::storage {

  # Common packages

  package { $bacula::params::package_storage_common: ensure => installed; }

  package { $bacula::params::package_storage_mysql: ensure => installed; }
}

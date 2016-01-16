# Class: bacula::package::file
#
# This class contain the packages for Bacula file daemon installation
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include bacula::package::file
#
class bacula::package::file {

  # file packages

  package { $bacula::params::package_file: ensure => installed; }
}

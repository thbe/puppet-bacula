# Class: bacula::package::common
#
# This class contain the packages for common Bacula installation
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include bacula::package::common
#
class bacula::package::common {

  # Common packages

  package { $bacula::params::package_common: ensure => installed; }
}

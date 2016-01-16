# Class: bacula::package
#
# This class contain the service configuration for Bacula
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include bacula::package
#
class bacula::package {
  include bacula::package::common

  if $bacula::type_fd {
    include bacula::package::file
  }

  if $bacula::type_sd {
    include bacula::package::storage
  }

  if $bacula::type_dir {
    include bacula::package::director
  }
}

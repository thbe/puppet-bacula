# Class: bacula::service
#
# This class contain the service configuration for Bacula
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include bacula::service
#
class bacula::service {

  if $bacula::type_fd {
    include bacula::service::file
  }

  if $bacula::type_sd {
    include bacula::service::storage
  }

  if $bacula::type_dir {
    include bacula::service::director
  }
}

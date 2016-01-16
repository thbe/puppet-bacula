# Class: bacula::config
#
# This class contain the configuration for Bacula
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include bacula::config
#
class bacula::config {
  include bacula::config::user

  if $bacula::type_fd {
    include bacula::config::file
  }

  if $bacula::type_sd {
    include bacula::config::storage
  }

  if $bacula::type_dir {
    include bacula::config::mysql
    include bacula::config::director
  }
}

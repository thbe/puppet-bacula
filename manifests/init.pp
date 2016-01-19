# Class: bacula
# ===========================
#
# Install a Bacula enterprise class backup instance.
#
# Parameters
# ----------
#
# Here is the list of parameters used by this module.
#
# * `type_fd`
#   Specify if file descriptor components should be installed
#   Default value is false
#
# * `type_sd`
#   Specify if storage daemon components should be installed
#   Default value is false
#
# * `type_dir`
#   Specify if director components should be installed
#   Default value is false
#
# * `db_password`
#   Specify the database password
#   Default value is 0nly4install
#
# * `db_password_hash`
#   Specify the database password hash
#   Default value is *31F96A5E321BF3E06E35668ED982CC2447CF5B3F
#
# * `client_password`
#   Specify the client password
#   Default value is client-password-for-bacula
#
# * `monitor_password`
#   Specify the monitor password
#   Default value is monitor-password-for-bacula
#
# * `storage_password`
#   Specify the storage daemon password
#   Default value is storage-password-for-bacula
#
# * `storage_daemon`
#   Specify the storage daemon that should be used
#   Default value is storage-daemon.domain.local
#
# * `mail_hub`
#   Specify the mail hub that should be used
#   Default value is mail-hub.domain.local
#
# * `mail_group`
#   Specify the mail group that should be used
#   Default value is bacula-list@domain.local
#
# * `backup_clients`
#   Specify the clients that should be backuped
#   Default value is no client
#
# Variables
# ----------
#
# No additonal variables are required for this module
#
# Examples
# --------
#
# @example
#    class { 'bacula':
#      type_fd => true,
#      type_sd => true,
#      type_dir => true,
#      client_password => 'Start123!',
#      monitor_password => 'Start123!',
#      storage_password => 'Start123!',
#      storage_daemon => 'bac-sd.example.local',
#      mail_hub => 'mail.example.local',
#      mail_group => 'bac-group@example.local',
#      backup_clients => [ 'client1.example.local', 'client2.example.local' ]
#    }
#
# Authors
# -------
#
# Thomas Bendler <project@bendler-net.de>
#
# Copyright
# ---------
#
# Copyright 2016 Thomas Bendler, unless otherwise noted.
#
class bacula (
  $type_fd                  = $bacula::params::type_fd,
  $type_sd                  = $bacula::params::type_sd,
  $type_dir                 = $bacula::params::type_dir,
  $db_password              = $bacula::params::db_password,
  $db_password_hash         = $bacula::params::db_password_hash,
  $client_password          = $bacula::params::client_password,
  $monitor_password         = $bacula::params::monitor_password,
  $storage_password         = $bacula::params::storage_password,
  $storage_daemon           = $bacula::params::storage_daemon,
  $mail_hub                 = $bacula::params::mail_hub,
  $mail_group               = $bacula::params::mail_group,
  $backup_clients           = []
  ) inherits bacula::params {

  # Start workflow
  if $bacula::params::linux {
    # Containment
    contain bacula::package
    contain bacula::config
    contain bacula::service

    # Include classes
    Class['bacula::package'] ->
    Class['bacula::config'] ->
    Class['bacula::service']
  }
  else {
    warning('The current operating system is not supported!')
  }
}

# Class: bacula::config::user
#
# This module manages Bacula backup user
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include bacula::config::user
#
class bacula::config::user {
  @group { 'bacula':
    ensure => present;
  }

  @user { 'bacula':
    ensure     => present,
    gid        => 'bacula',
    comment    => 'Bacula Backup System',
    home       => '/var/spool/bacula',
    shell      => '/sbin/nologin',
    managehome => false,
    password   => '!!',
    require    => Group['bacula'];
  }

  realize Group['bacula']
  realize User['bacula']
}

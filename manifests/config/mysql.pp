# Class: bacula::config::mysql
#
# This class contain the configuration for Bacula MySQL databases
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include bacula::config::mysql
#
class bacula::config::mysql {
  # Setup mysql databases
  class { '::mysql::server':
    root_password    => $bacula::db_password,
    override_options => {
      'mysqld' => {
        'max_connections' => '1024'
        }
      },
    databases        => {
      'bacula' => {
        # lint:ignore:ensure_first_param
        ensure  => present,
        # lint:endignore
        charset => 'utf8',
      },
    },
    grants           => {
      'bacula@localhost/bacula.*' => {
        ensure     => present,
        options    => [ 'GRANT' ],
        privileges => [ 'CREATE', 'CREATE VIEW', 'INDEX', 'SELECT', 'INSERT', 'UPDATE', 'DELETE', 'DROP', 'EXECUTE' ],
        table      => 'bacula.*',
        user       => 'bacula@localhost',
      },
    },
    users            => {
      'bacula@localhost' => {
        ensure                   => 'present',
        max_connections_per_hour => '0',
        max_queries_per_hour     => '0',
        max_updates_per_hour     => '0',
        max_user_connections     => '0',
        password_hash            => $bacula::db_password_hash,
      },
    },
  }

  class { '::mysql::server::backup':
    backupdir      => '/srv/mysql',
    backuppassword => $bacula::db_password,
    backupuser     => 'bckadm',
  }

  include mysql::server::account_security
  include mysql::server::mysqltuner

  # Create schema population script
  file { $bacula::params::config_schema_script:
    ensure  => file,
    mode    => '0755',
    source  => $bacula::params::config_schema_script_file,
    require => Package[$bacula::params::package_director_mysql];
  }

  # Execute schema population script
  exec { '/etc/bacula/populate_bacula_schema.sh':
    path   => '/bin:/sbin:/usr/bin:/usr/sbin',
    onlyif => 'test -x /etc/bacula/populate_bacula_schema.sh',
    unless => 'test -f /etc/sysconfig/mysqldb_bacula'
  }
}

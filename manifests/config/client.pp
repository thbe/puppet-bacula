# Class: bacula::config::client
#
# This module manages Bacula backup clients
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage:
#
define bacula::config::client (
  $client_fqdn      = $title,
  $fileset          = 'UnixServerComplete',
  $file_retention   = '10 days',
  $job_retention    = '30 days'
  ) {

  # Define local variables for template
  $local_client_fqdn     = $client_fqdn
  $local_fileset         = $fileset
  $local_file_retention  = $file_retention
  $local_job_retention   = $job_retention

  # Create client defintion
  file { "${bacula::params::config_confd_clients_dir}/${client_fqdn}.conf":
    ensure  => file,
    mode    => '0644',
    content => template($bacula::params::config_confd_client_template),
    notify  => Service[$bacula::params::service_director],
    require => Package[$bacula::params::package_director_mysql];
  }

  # Create job definition
  file { "${bacula::params::config_confd_jobs_dir}/${client_fqdn}.conf":
    ensure  => file,
    mode    => '0644',
    content => template($bacula::params::config_confd_job_template),
    notify  => Service[$bacula::params::service_director],
    require => Package[$bacula::params::package_director_mysql];
  }
}

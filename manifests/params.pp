# Class: bacula::params
#
# This module manages Bacula parameter
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include bacula::params
#
class bacula::params {
  # Operating system specific definitions
  case $::osfamily {
    'RedHat' : {
      $linux                                      = true

      # Package definition
      $package_common                             = 'bacula-common'
      $package_file                               = 'bacula-client'
      $package_storage_common                     = 'bacula-storage-common'
      $package_storage_mysql                      = 'bacula-storage-mysql'
      $package_director_common                    = 'bacula-director-common'
      $package_director_mysql                     = 'bacula-director-mysql'
      $package_console                            = 'bacula-console'

      # Config definition
      $config_file                                = '/etc/bacula/bacula-fd.conf'
      $config_file_template                       = 'bacula/etc/bacula-fd.conf.erb'
      $config_storage                             = '/etc/bacula/bacula-sd.conf'
      $config_storage_template                    = 'bacula/etc/bacula-sd.conf.erb'
      $config_director                            = '/etc/bacula/bacula-dir.conf'
      $config_director_template                   = 'bacula/etc/bacula-dir.conf.erb'
      $config_confd_dir                           = '/etc/bacula/conf.d'
      $config_confd_clients_dir                   = '/etc/bacula/conf.d/clients'
      $config_confd_jobs_dir                      = '/etc/bacula/conf.d/jobs'
      $config_confd_catalog                       = '/etc/bacula/conf.d/catalog.conf'
      $config_confd_catalog_template              = 'bacula/etc/conf.d/catalog.conf.erb'
      $config_confd_client_director               = '/etc/bacula/conf.d/client-director.conf'
      $config_confd_client_director_template      = 'bacula/etc/conf.d/client-director.conf.erb'
      $config_confd_console                       = '/etc/bacula/conf.d/console.conf'
      $config_confd_console_template              = 'bacula/etc/conf.d/console.conf.erb'
      $config_confd_director                      = '/etc/bacula/conf.d/director.conf'
      $config_confd_director_template             = 'bacula/etc/conf.d/director.conf.erb'
      $config_confd_fileset                       = '/etc/bacula/conf.d/fileset.conf'
      $config_confd_fileset_template              = 'bacula/etc/conf.d/fileset.conf.erb'
      $config_confd_job_backup_catalog            = '/etc/bacula/conf.d/job-backup-catalog.conf'
      $config_confd_job_backup_catalog_template   = 'bacula/etc/conf.d/job-backup-catalog.conf.erb'
      $config_confd_job_director                  = '/etc/bacula/conf.d/job-director.conf'
      $config_confd_job_director_template         = 'bacula/etc/conf.d/job-director.conf.erb'
      $config_confd_job_restore                   = '/etc/bacula/conf.d/job-restore.conf'
      $config_confd_job_restore_template          = 'bacula/etc/conf.d/job-restore.conf.erb'
      $config_confd_jobdefs                       = '/etc/bacula/conf.d/jobdefs.conf'
      $config_confd_jobdefs_template              = 'bacula/etc/conf.d/jobdefs.conf.erb'
      $config_confd_messages                      = '/etc/bacula/conf.d/messages.conf'
      $config_confd_messages_template             = 'bacula/etc/conf.d/messages.conf.erb'
      $config_confd_pool                          = '/etc/bacula/conf.d/pool.conf'
      $config_confd_pool_template                 = 'bacula/etc/conf.d/pool.conf.erb'
      $config_confd_schedule                      = '/etc/bacula/conf.d/schedule.conf'
      $config_confd_schedule_template             = 'bacula/etc/conf.d/schedule.conf.erb'
      $config_confd_storage                       = '/etc/bacula/conf.d/storage.conf'
      $config_confd_storage_template              = 'bacula/etc/conf.d/storage.conf.erb'

      $config_schema_script                       = '/etc/bacula/populate_bacula_schema.sh'
      $config_schema_script_file                  = 'puppet:///modules/bacula/etc/populate_bacula_schema.sh'

      $config_confd_client_template               = 'bacula/etc/conf.d/client-template.conf.erb'
      $config_confd_job_template                  = 'bacula/etc/conf.d/job-template.conf.erb'

      # Service definition
      $service_file                               = 'bacula-fd'
      $service_storage                            = 'bacula-sd'
      $service_director                           = 'bacula-dir'
    }
    default  : {
      $linux                                      = false
    }
  }

  # Bacula definitions
  $type_fd                  = false
  $type_sd                  = false
  $type_dir                 = false
  $db_password              = '0nly4install'
  $db_password_hash         = '*31F96A5E321BF3E06E35668ED982CC2447CF5B3F'
  $client_password          = 'client-password-for-bacula'
  $monitor_password         = 'monitor-password-for-bacula'
  $storage_password         = 'storage-password-for-bacula'
  $storage_daemon           = 'storage-daemon.domain.local'
  $mail_hub                 = 'mail-hub.domain.local'
  $mail_group               = 'bacula-list@domain.local'
}

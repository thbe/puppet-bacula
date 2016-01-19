# bacula

[![Build Status](https://travis-ci.org/thbe/puppet-bacula.png?branch=master)](https://travis-ci.org/thbe/puppet-bacula)
[![Puppet Forge](https://img.shields.io/puppetforge/v/thbe/bacula.svg)](https://forge.puppetlabs.com/thbe/bacula)
[![Coverage Status](https://coveralls.io/repos/thbe/puppet-ssmtp/badge.svg?branch=master&service=github)](https://coveralls.io/github/thbe/puppet-bacula?branch=master)

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with bacula](#setup)
    * [What bacula affects](#what-bacula-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with bacula](#beginning-with-bacula)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

This module install and configure the enterprise class Bacula backup solution. It could
be used for all three components, the client, the server and the storage side.

## Setup

### What bacula affects

* The module install packages based on usage type.
* The module configure the services based on usage type.
* The module start the necessary services based on usage type.
* The module install and configure MySQL if used as backup server.

### Setup Requirements

No additional actions needed to use this module.

### Beginning with bacula

This module could be used to install and configure three components needed to
perform distributed backups.

## Usage

This module can install the:

* Bacula director
* Bacula storage daemon
* Bacula file descriptor

### Bacula director

```puppet
class { 'bacula':
  type_dir => true,
  client_password => 'Start123!',
  monitor_password => 'Start123!',
  storage_password => 'Start123!',
  storage_daemon => 'bac-sd.example.local',
  mail_hub => 'mail.example.local',
  mail_group => 'bac-group@example.local',
  backup_clients => [ 'client1.example.local', 'client2.example.local' ]
}
```

### Bacula storage daemon

```puppet
class { 'bacula':
  type_sd => true,
  monitor_password => 'Start123!',
  storage_password => 'Start123!',
  storage_daemon => 'bac-sd.example.local'
}
```

### Bacula file descriptor

```puppet
class { 'bacula':
  type_fd => true,
  client_password => 'Start123!',
  monitor_password => 'Start123!'
}
```

## Reference

Here is the list of parameters used by this module.

#### `$type_fd`

Specify if file descriptor components should be installed
Default value is false

#### `$type_sd`

Specify if storage daemon components should be installed
Default value is false

#### `$type_dir`

Specify if director components should be installed
Default value is false

#### `$db_password`

Specify the database password
Default value is 0nly4install

#### `$db_password_hash`

Specify the database password hash
Default value is \*31F96A5E321BF3E06E35668ED982CC2447CF5B3F

#### `$client_password`

Specify the client password
Default value is client-password-for-bacula

#### `$monitor_password`

Specify the monitor password
Default value is monitor-password-for-bacula

#### `$storage_password`

Specify the storage daemon password
Default value is storage-password-for-bacula

#### `$storage_daemon`

Specify the storage daemon that should be used
Default value is storage-daemon.domain.local

#### `$mail_hub`

Specify the mail hub that should be used
Default value is mail-hub.domain.local

#### `$mail_group`

Specify the mail group that should be used
Default value is bacula-list@domain.local

#### `$backup_clients`

Specify the clients that should be backuped
Default value is no client

## Limitations

This module has been built on and tested against Puppet 4.0 and higher.

The module has been tested on:

* CentOS Linux 7

Testing on other platforms has been light and cannot be guaranteed.

This module does currently only support a limited set of distributions and need to be
reworked for other distributions as well.

## Development

If you like to add or improve this module, feel free to fork the module and send
me a merge request with the modification.

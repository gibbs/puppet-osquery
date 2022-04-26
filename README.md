# osquery

[![Build Status](https://github.com/gibbs/puppet-osquery/workflows/CI/badge.svg)](https://github.com/gibbs/puppet-osquery/actions?query=workflow%3ACI)
[![Release](https://github.com/gibbs/puppet-osquery/workflows/Release/badge.svg)](https://github.com/gibbs/puppet-osquery/actions?query=workflow%3ARelease)
[![Puppet Forge](https://img.shields.io/puppetforge/v/genv/osquery.svg?maxAge=2592000?style=plastic)](https://forge.puppet.com/genv/osquery)
[![Apache-2 License](https://img.shields.io/github/license/gibbs/puppet-osquery.svg)](LICENSE)

Install, configure and manage osquery.

## Usage

Include the `osquery` class to install the package and run `osqueryd` with
minimal configuration.

```puppet
include osquery
```

## Configuration

The `settings` parameter accepts any hash that is saved as JSON to
`/etc/osquery/osquery.conf`.

```puppet
class { 'osquery':
  settings => {
    options   => {
      config_plugin   => 'filesystem',
      disable_logging => 'false',
      logger_plugin   => 'syslog',
    },
    discovery => [
      'SELECT pid FROM processes WHERE name = \'foobar\';',
      'SELECT 1 FROM users WHERE username like \'www%\';',
    ],
  }
}
```

```yaml
osquery::settings:
  options:
    config_plugin: filesystem
    logger_plugin: syslog
    host_identifier: uuid
  schedule:
    foobar:
      query: SELECT foo, bar, pid FROM foobar_table;
      interval: 600
  packs:
    shard: 10
    external_pack: /path/to/external_pack.conf
    queries:
      suid_bins:
        query: SELECT * FROM suid_bins;
        interval: 3600
```

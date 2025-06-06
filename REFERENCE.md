# Reference

<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Table of Contents

### Classes

#### Public Classes

* [`osquery`](#osquery): osquery

#### Private Classes

* `osquery::config`: osquery configuration
* `osquery::package`: osquery package management
* `osquery::service`: osquery service management

## Classes

### <a name="osquery"></a>`osquery`

osquery

#### Parameters

The following parameters are available in the `osquery` class:

* [`config_path`](#-osquery--config_path)
* [`config_owner`](#-osquery--config_owner)
* [`config_group`](#-osquery--config_group)
* [`package_name`](#-osquery--package_name)
* [`package_ensure`](#-osquery--package_ensure)
* [`package_provider`](#-osquery--package_provider)
* [`package_install_options`](#-osquery--package_install_options)
* [`service_name`](#-osquery--service_name)
* [`service_enable`](#-osquery--service_enable)
* [`service_ensure`](#-osquery--service_ensure)
* [`manage_repo`](#-osquery--manage_repo)
* [`repo_url`](#-osquery--repo_url)
* [`repo_key_id`](#-osquery--repo_key_id)
* [`repo_key_server`](#-osquery--repo_key_server)
* [`repo_key_name`](#-osquery--repo_key_name)
* [`repo_key_source`](#-osquery--repo_key_source)
* [`settings`](#-osquery--settings)
* [`validate_cmd`](#-osquery--validate_cmd)

##### <a name="-osquery--config_path"></a>`config_path`

Data type: `Stdlib::AbsolutePath`

The absolute path to the osquery configuration file

Default value: `'/etc/osquery/osquery.conf'`

##### <a name="-osquery--config_owner"></a>`config_owner`

Data type: `Variant[Integer[0], String[1]]`

The owner to set on the osquery configuration file

Default value: `0`

##### <a name="-osquery--config_group"></a>`config_group`

Data type: `Variant[Integer[0], String[1]]`

The group to set on the osquery configuration file

Default value: `0`

##### <a name="-osquery--package_name"></a>`package_name`

Data type: `String[1]`

The osquery package name

Default value: `'osquery'`

##### <a name="-osquery--package_ensure"></a>`package_ensure`

Data type: `String`

The osquery package ensure state

Default value: `'installed'`

##### <a name="-osquery--package_provider"></a>`package_provider`

Data type: `Optional[String]`

The package provider to use (Windows)

Default value: `undef`

##### <a name="-osquery--package_install_options"></a>`package_install_options`

Data type: `Optional[Array]`

The install_options to provide when using Chocolatey (Windows)

Default value: `undef`

##### <a name="-osquery--service_name"></a>`service_name`

Data type: `String[1]`

The osquery service name

Default value: `'osqueryd'`

##### <a name="-osquery--service_enable"></a>`service_enable`

Data type: `Boolean`

The osquery service enable state

Default value: `true`

##### <a name="-osquery--service_ensure"></a>`service_ensure`

Data type: `Stdlib::Ensure::Service`

The osquery service ensure state

Default value: `'running'`

##### <a name="-osquery--manage_repo"></a>`manage_repo`

Data type: `Boolean`

Set to true to manage the osquery repository

Default value: `true`

##### <a name="-osquery--repo_url"></a>`repo_url`

Data type: `Optional[String]`

The osquery repository URL to use

Default value: `undef`

##### <a name="-osquery--repo_key_id"></a>`repo_key_id`

Data type: `Optional[String]`

The osquery repository GPG key id (apt)

Default value: `undef`

##### <a name="-osquery--repo_key_server"></a>`repo_key_server`

Data type: `Optional[String]`

The osquery GPG key server (apt) or GPG URL (yum)

Default value: `undef`

##### <a name="-osquery--repo_key_name"></a>`repo_key_name`

Data type: `Optional[String]`

The osquery APT keyring name

Default value: `undef`

##### <a name="-osquery--repo_key_source"></a>`repo_key_source`

Data type: `Optional[String]`

The osquery APT keyring file source

Default value: `undef`

##### <a name="-osquery--settings"></a>`settings`

Data type: `Hash`

A hash of settings to set in the osquery configuration file

Default value: `{}`

##### <a name="-osquery--validate_cmd"></a>`validate_cmd`

Data type: `String`

The command to validate osquery.conf format changes

Default value: `'/usr/bin/osqueryi --config_path % --config_check'`


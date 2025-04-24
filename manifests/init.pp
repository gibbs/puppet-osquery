# @summary osquery
#
# @param config_path
#   The absolute path to the osquery configuration file
#
# @param config_owner
#   The owner to set on the osquery configuration file
#
# @param config_group
#   The group to set on the osquery configuration file
#
# @param package_name
#   The osquery package name
#
# @param package_ensure
#   The osquery package ensure state
#
# @param package_provider
#   The package provider to use (Windows)
#
# @param package_install_options
#   The install_options to provide when using Chocolatey (Windows)
#
# @param service_name
#   The osquery service name
#
# @param service_enable
#   The osquery service enable state
#
# @param service_ensure
#   The osquery service ensure state
#
# @param manage_repo
#   Set to true to manage the osquery repository
#
# @param repo_url
#   The osquery repository URL to use
#
# @param repo_key_id
#   The osquery repository GPG key id (apt)
#
# @param repo_key_server
#   The osquery GPG key server (apt) or GPG URL (yum)
#
# @param repo_key_name
#   The osquery APT keyring name
#
# @param repo_key_source
#   The osquery APT keyring file source
#
# @param settings
#   A hash of settings to set in the osquery configuration file
#
# @param validate_cmd
#   The command to validate osquery.conf format changes
#
# @author Dan Gibbs <dev@dangibbs.co.uk>
#
class osquery (
  Stdlib::AbsolutePath $config_path            = '/etc/osquery/osquery.conf',
  Variant[Integer[0], String[1]] $config_owner = 0,
  Variant[Integer[0], String[1]] $config_group = 0,
  String[1] $package_name                      = 'osquery',
  String $package_ensure                       = 'installed',
  Optional[String] $package_provider           = undef,
  Optional[Array] $package_install_options     = undef,
  String[1] $service_name                      = 'osqueryd',
  Boolean $service_enable                      = true,
  Stdlib::Ensure::Service $service_ensure      = 'running',
  Boolean $manage_repo                         = true,
  Optional[String] $repo_url                   = undef,
  Optional[String] $repo_key_id                = undef,
  Optional[String] $repo_key_server            = undef,
  Optional[String] $repo_key_name              = undef,
  Optional[String] $repo_key_source            = undef,
  Hash $settings                               = {},
  String $validate_cmd                         = '/usr/bin/osqueryi --config_path % --config_check',
) {
  contain osquery::package
  contain osquery::config
  contain osquery::service

  Class['osquery::package']
  -> Class['osquery::config']
  -> Class['osquery::service']
}

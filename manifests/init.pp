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
#   The osquery GPG key server to use (apt)
#
# @param settings
#   A hash of settings to set in the osquery configuration file
#
# @author Dan Gibbs <dev@dangibbs.co.uk>
#
class osquery (
  Stdlib::AbsolutePath $config_path            = '/etc/osquery/osquery.conf',
  Variant[Integer[0], String[1]] $config_owner = 0,
  Variant[Integer[0], String[1]] $config_group = 0,
  String[1] $package_name                      = 'osquery',
  String $package_ensure                       = 'installed',
  String[1] $service_name                      = 'osqueryd',
  Boolean $service_enable                      = true,
  Stdlib::Ensure::Service $service_ensure      = 'running',
  Boolean $manage_repo                         = true,
  String $repo_url                             = undef,
  String $repo_key_id                          = undef,
  String $repo_key_server                      = undef,
  Hash $settings                               = {},
) {

  contain osquery::package
  contain osquery::config
  contain osquery::service

  Class['osquery::package']
  -> Class['osquery::config']
  -> Class['osquery::service']
}

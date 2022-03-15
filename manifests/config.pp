# @summary osquery configuration
#
# @api private
#
class osquery::config {
  assert_private()

  file { $osquery::config_path:
    ensure  => present,
    owner   => $osquery::config_owner,
    group   => $osquery::config_group,
    mode    => '0640',
    content => to_json_pretty($osquery::settings),
    notify  => Service[$osquery::service_name],
    require => Package[$osquery::package_name],
  }
}

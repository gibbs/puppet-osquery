# @summary osquery configuration
#
# @api private
#
class osquery::config {
  assert_private()

  file { $osquery::config_path:
    ensure       => file,
    owner        => $osquery::config_owner,
    group        => $osquery::config_group,
    mode         => '0640',
    content      => stdlib::to_json_pretty($osquery::settings),
    notify       => Service[$osquery::service_name],
    require      => Package[$osquery::package_name],
    validate_cmd => $osquery::validate_cmd,
  }
}

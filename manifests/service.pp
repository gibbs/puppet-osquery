# @summary osquery service management
#
# @api private
#
class osquery::service {
  assert_private()

  service { $osquery::service_name:
    ensure     => $osquery::service_ensure,
    enable     => $osquery::service_enable,
    hasstatus  => true,
    hasrestart => true,
    require    => Package[$osquery::package_name],
  }
}

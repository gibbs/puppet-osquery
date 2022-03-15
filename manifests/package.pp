# @summary osquery package management
#
# @api private
#
class osquery::package {
  assert_private()

  if $osquery::manage_repo {
    case $facts[os][family] {
      'Debian': {
        apt::source { 'osquery':
          location => $osquery::repo_url,
          release  => 'deb',
          repos    => 'main',
          key      => {
            id     => $osquery::repo_key_id,
            server => $osquery::repo_key_server,
          }
        }

        Package<|title == $osquery::package_name|> {
          require => Apt::Source['osquery'],
        }
      }
      default: {
        fail("Repository for ${facts[os][family]} is not supported.")
      }
    }
  }

  package { $osquery::package_name:
    ensure  => $osquery::package_ensure,
  }
}

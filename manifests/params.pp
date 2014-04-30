# == Class wildfly::params
#
# This class is meant to be called from wildfly
# It sets variables according to platform
#
class wildfly::params {

  $user = "wildfly"
  $shell = "/bin/bash"
  $install_dir = "/opt"
  $version = "8.0.0.Final"
  $mode = "standalone"
  $profile = "standalone.xml"
  $wait_time = "60"
  $console_log = "/var/log/wildfly/console.log"
  $pid_file = "/var/run/wildfly/wildfly.pid"

  case $::osfamily {
    'RedHat': {
      $default_conf = "/etc/default/wildfly.conf"
      $init_script = "wildfly-init-redhat.sh"
    }
    'Debian': {
      $default_conf = "/etc/default/wildfly"
      $init_script = "wildfly-init-debian.sh"
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }

}

# == Class wildfly::service
#
# This class is meant to be called from wildfly
# It ensure the service is running
#
class wildfly::service {

  service { 'wildfly':
    ensure      => running,
    enable      => true,
    hasstatus   => true,
    hasrestart  => true,
  }

}

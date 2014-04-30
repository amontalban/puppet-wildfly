# == Class wildfly::config
#
class wildfly::config {

  file { "${wildfly::install_dir}/wildfly/${wildfly::mode}/configuration/${wildfly::profile}":
    ensure  => present,
    require => [ User["${wildfly::user}"], File["${wildfly::install_dir}/wildfly"] ],
    owner   => "${wildfly::user}",
    group   => "${wildfly::user}",
    mode    => 0644,
    source  => [ "puppet:///modules/wildfly/${wildfly::profile}" ]
  }

  file { "${wildfly::default_conf}":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 0644,
    content => template('wildfly/wildfly.conf.erb')
  }

  file { "/etc/init.d/wildfly":
    ensure  => present,
    require => File["${wildfly::default_conf}"],
    owner   => root,
    group   => 0755,
    source  => [ "puppet:///modules/wildfly/${wildfly::init_script}" ]
  }

}

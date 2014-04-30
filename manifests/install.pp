# == Class wildfly::install
#
class wildfly::install {

  Exec { path => [ '/bin', '/sbin', '/usr/bin', '/usr/sbin', '/usr/local/bin', '/usr/local/sbin' ], }

  file { "/usr/src/wildfly-${wildfly::version}.tar.gz":
    source => [ "puppet:///modules/wildfly/wildfly-${wildfly::version}.tar.gz" ]
  }

  exec { untar-wildfly:
    command     => "tar xzf /usr/src/wildfly-${wildfly::version}.tar.gz",
    cwd         => "${wildfly::install_dir}", 
    creates     => "${wildfly::install_dir}/wildfly-${wildfly::version}",
    subscribe   => File["/usr/src/wildfly-${wildfly::version}.tar.gz"],
    refreshonly => true
  }

  file { "${wildfly::install_dir}/wildfly":
    ensure  => 'link',
    owner   => "${wildfly::user}",
    group   => "${wildfly::user}",
    target  => "${wildfly::install_dir}/wildfly-${wildfly::version}",
    require => Exec[untar-wildfly]
  }

  user { "${wildfly::user}":
    shell   => "${wildfly::shell}",
    ensure  => "present"
  }

  exec { chown-wildfly:
    command => "chown -R ${wildfly::user}:${wildfly::user} ${wildfly::install_dir}/wildfly/*",
    require => [ User["${wildfly::user}"], File["${wildfly::install_dir}/wildfly"] ],
    subscribe => Exec[untar-wildfly],
    refreshonly => true
  }

}

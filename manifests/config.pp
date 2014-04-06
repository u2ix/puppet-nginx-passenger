class nginx_passenger::config inherits nginx_passenger {
  file { 'nginx-config':
    path    => "${installdir}/conf/nginx.conf",
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('nginx_passenger/nginx.conf.erb'),
    require => Exec['nginx-install'],
  }

  exec { 'create sites-conf':
    path    => ['/usr/bin','/bin'],
    unless  => "/usr/bin/test -d  ${installdir}/conf/sites-available && /usr/bin/test -d ${installdir}/conf/sites-enabled",
    command => "/bin/mkdir  ${installdir}/conf/sites-available && /bin/mkdir ${installdir}/conf/sites-enabled",
    require => Exec['nginx-install'],
  }

  file { 'nginx-service':
    path      => '/etc/init.d/nginx',
    owner     => 'root',
    group     => 'root',
    mode      => '0755',
    content   => template('nginx_passenger/nginx.init.erb'),
    require   => File['nginx-config'],
    subscribe => File['nginx-config'],
  }

  file { $logdir:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0644'
  }
}
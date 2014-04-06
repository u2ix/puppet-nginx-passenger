class nginx_passenger::service inherits nginx_passenger {
  service { 'nginx':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    subscribe  => File['nginx-config'],
    require    => [ File[$logdir], File['nginx-service']],
  }
}
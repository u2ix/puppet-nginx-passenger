class nginx_passenger::package inherits nginx_passenger {
  
  $passenger_deps = [ $ruby_version, 'build-essential', 'openssl', 'curl', 'libssl-dev', 'zlib1g', 'zlib1g-dev', 'libcurl4-openssl-dev', 'ruby-dev' ]

  package { $passenger_deps: ensure => present } 

}
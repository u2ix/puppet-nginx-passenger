class nginx_passenger::install inherits nginx_passenger {
  $base_options = "--auto --prefix=${installdir}"

    if $nginx_source_dir {
      if $nginx_extra_configure_flags {
        # Double escape with help of slashes outside the escaped quote since options
        # get passed down to another set of escaped quotes
        # and then to the shell
        $options = "${base_options} --nginx-source-dir ${nginx_source_dir} --extra-configure-flags \\\"${nginx_extra_configure_flags}\\\""
      }
      else {
        $options = "${base_options} --nginx-source-dir ${nginx_source_dir}"
      }
    }
    else {
      $options = "${base_options} --auto-download"  
    }

    package { 'install passenger':
      name => 'passenger',
      ensure => $passenger_version,
      provider => 'gem',
    }

    #exec { 'install passenger':
    #  command => "/usr/bin/gem install passenger",
    #  unless => "/usr/bin/test -f /usr/local/bin/passenger-install-nginx-module",
    #  before => Exec['create container']
    #}

    # gem list --local |grep passenger |awk -F '[()]' '{print $(NF-1)}'

        exec { 'create container':
      command => "/bin/mkdir ${www} && /bin/chown www-data:www-data ${www} && /bin/chmod g+rws ${www}",
      unless  => "/usr/bin/test -d ${www}",
      before  => Exec['nginx-install']
    }

    exec { 'nginx-install':
      command => "/usr/local/bin/passenger-install-nginx-module ${options}",
      group   => 'root',
      timeout => 1800,
      unless  => "/usr/bin/test -d ${installdir}",
      require => [ Package['install passenger'] ],
    }
  }
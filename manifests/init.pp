# Class: nginx_passenger
#
# This module installs Nginx and its default configuration.
#
# Parameters:
#   $ruby_version
#       Ruby version to install.
#   $passenger_version
#      Passenger version to install.
#   $logdir
#      Nginx's log directory.
#   $installdir
#      Nginx's install directory.
#   $www
#      Base directory for
# Actions:
#
# Sample Usage:  include nginx_passenger
class nginx_passenger (
  $ruby_version = '1.9.1',
  $passenger_version = '4.0.40',
  $logdir = '/var/log/nginx',
  $installdir = '/opt/nginx',
  $www    = '/var/www',
  $nginx_source_dir = '',
  $nginx_extra_configure_flags = '') {


  anchor { 'nginx_passenger::begin': } ->
  class { '::nginx_passenger::package': } ->
  class { '::nginx_passenger::install': } ->
  class { '::nginx_passenger::config': } ->
  class { '::nginx_passenger::service': } ->
  anchor { 'nginx_passenger::end': }
}

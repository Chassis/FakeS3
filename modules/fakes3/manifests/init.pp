# A Chassis extension to install and configure Fake S3
class fakes3 (
  $config,
) {

  # Default settings for install
  $defaults = {
    'port' => 4569,
    'path' => '/mnt/fakes3_root',
  }

  # Allow override from config.yaml
  $options = deep_merge($defaults, $config[fakes3])

  package { 'fakes3':
    ensure   => 'installed',
    provider => 'gem',
  }

  exec { 'start fakes3':
    command => "fakes3 -r ${options[path]} -p ${options[port]}",
    require => Package['fakes3'],
  }

  file_line { 'FAKE_S3_PORT':
    path => '/etc/environment',
    line => "FAKE_S3_PORT=${options[port]}"
  }

}

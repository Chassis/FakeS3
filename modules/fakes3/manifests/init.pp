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

  $port = $options[port]
  $path = $options[path]

  if ( !empty($config[disabled_extensions]) and 'chassis/fakes3' in $config[disabled_extensions] ) {

    # Kill the service if running
    service { 'fakes3':
      ensure   => 'stopped',
      binary   => "/usr/local/bin/fakes3 -r ${path} -p ${port}",
      provider => 'base',
      before   => Package['fakes3']
    }

    # Remove the package
    package { 'fakes3':
      ensure   => 'absent',
      provider => 'gem',
    }

    # Remove the local-config.php file
    file { '/vagrant/extensions/fakes3/local-config.php':
      ensure => 'absent',
    }

  } else {

    # Install fakes3 gem
    package { 'fakes3':
      ensure   => 'installed',
      provider => 'gem',
    }

    # Create the mount point
    file { $path:
      ensure => 'directory',
    }

    # Start the service
    service { 'fakes3':
      ensure   => 'running',
      binary   => "/usr/local/bin/fakes3 -r ${path} -p ${port}",
      enable   => true,
      provider => 'base',
      require  => [ Package['fakes3'], File[$path] ],
    }

    # Create default bucket
    exec { 'fakes3 bucket':
      command => "/usr/bin/curl -H \"Host: chassis.s3.amazonaws.com\" -H \"x-amz-acl: public-read\" -XPUT http://localhost:${port}"
    }

    # Make port number available to PHP
    file { '/vagrant/extensions/fakes3/local-config.php':
      ensure  => 'present',
      content => template('fakes3/local-config.php.erb'),
    }
  }
}

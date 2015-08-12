class holding_page (
  $access_key = 'test',
  $include_rewrite_rules = true,
  $enabled = false,
  $directory = '/var/www/html/holding_page',
  $touch_file = 'holding_page_enabled',
  $holding_page_uri = '/holding_page.html'
) {

  file { '/etc/httpd/conf.d/holding_page.conf'
    content => template('holding_page/holding_page.conf.erb')
    require => Package[httpd]
  }

  file { $directory:
    ensure  => directory,
    owner   => 'apache',
    group   => 'apache',
    mode    => '0755',
    require => Package[httpd]
  }

  if $enabled != false {

    file { "${directory}/${touch_file}":
      ensure  => present,
      owner   => 'apache',
      group   => 'apache',
      mode    => '0644',
      require => File[$directory]
    }
  }

  file { "${directory}/enable":
    content => template('holding_page/enable.erb')
    owner   => 'root',
    group   => 'apache',
    mode    => '0755',
    require => File[$directory]
  }

  file { "${directory}/disable":
    content => template('holding_page/disable.erb')
    owner   => 'root',
    group   => 'apache',
    mode    => '0755',
    require => File[$directory]
  }

}

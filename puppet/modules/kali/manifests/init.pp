class kali::myklass {
  file {
    'kali':
      ensure => 'file',
      source => 'puppet:///modules/kali/manifests/kali.sh',
      path => '/usr/local/bin/kali.sh',
      owner => 'root'
      group => 'root'
      mode  => '0744', # Use 0700 if it is sensitive
      notify => Exec['run_my_script'],
  }
  exec {
    'run_my_script':
     command => '/usr/local/bin/kali.sh',
     refreshonly => true,
  }
}
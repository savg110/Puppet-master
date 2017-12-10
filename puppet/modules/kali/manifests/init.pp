class kali {
	File { owner => '0', group => '0', mode => '0644', }
	Service { ensure => 'running', enable => true, }
	Package { ensure => 'latest', allowcdrom => true, }
	Exec { path =>  [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ], }
	
	file { '/etc/apt/sources.list':
			ensure => present,
			}->
	file_line { 'Append a line to /etc/apt/sources.list':
				path => '/etc/apt/sources.list',  
				line => 'deb http://http.kali.org/kali kali-rolling main contrib non-free',
			}

	exec { 'export DEBIAN_FRONTEND=noninteractive': }
	
	package { 'kali-linux-full': }

	
}
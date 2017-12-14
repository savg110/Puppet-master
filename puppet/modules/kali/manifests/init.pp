class kali {
	File { owner => '0', group => '0', mode => '0644', }
	Package { ensure => 'latest', allowcdrom => true, }
	Exec { path =>  [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ], }
	
	
	package { 'kali-linux-full': }

	
}

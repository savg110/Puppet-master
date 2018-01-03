class kali {
	Package { ensure => 'latest', allowcdrom => true, }
	
	
	package { 'kali-linux-full': }

	
}

class openssh {
	  #Paketin asennuksen varmistus
	package { ssh:
	ensure => 'installed',
	  #livetikun salliminen kun sellaista käytetään
	#allowcdrom => true,
	}	

	  #SSH konfiguraatio tiedostojen muokkaaminen.
	file { '/etc/ssh/ssh_config':
	content => template("openssh/ssh_config"),
	  #servicen huomautus ssh_config tiedoston muuttuessa
	notify => Service["ssh"],
	}

	  #ssh moduulin toiminnan varmistaminen.
	service { 'ssh':
	ensure => 'running',
	enable => 'true',
	}
}

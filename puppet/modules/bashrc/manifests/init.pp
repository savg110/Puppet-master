class bashrc {
		file { '/etc/skel/.bashrc':
				content => template('bashrc/.bashrc'),
			}
}
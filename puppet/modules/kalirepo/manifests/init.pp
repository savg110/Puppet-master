class kalirepo {
	file{ '/etc/apt/sources.list':
	ensure	=> 'present',
	mode	=> '0644',
	source	=> 'puppet:///modules/kalirepo/sources.list',
	replace => 'true'
}

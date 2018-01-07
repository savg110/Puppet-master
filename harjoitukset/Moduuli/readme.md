# Tavoite
Tavoitteena on saada valmiiksi skripti joka varmistaa kali työkalujen asentumisen helposti uudelle työpöytä alustalle.



# Aloitus
Alkuun katsoin [Tero Karvisen](http://terokarvinen.com/2017/automaticaly-build-penetration-testing-environment-kali-metasploitable-vagrant) sivuilla mainitun opinnäytetyön joka kohdistuu nimenomaan kali työkalujen asennukseen linux pohjaiseen työpöytään.

Tulin siihen lopputulokseen että en voi käyttää kyseistä asennus skriptiä moduuilissani mutta kuitenkin pystyin käyttämään osan siitä joka asentaa kali ohjelmiston halutulle koneelle.

Muokkasin H2 käytettyä bash skriptiä siten, että se asentaa käyttäjälle tree demonin ja puppetin. Lisäksi skripti muokkaa puppetin konfiguraatio tiedostoja ja määrittää master serverin ja myös määrittää master serverin "/etc/hosts" tiedostossa. Tätä skriptiä tullaan käyttämään orjakoneella.

![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/Moduuli/pics/1.png?raw=true)

Skriptissä käyeteyt grep komennot sain [Tero Karvisen](http://terokarvinen.com/2017/provision-multiple-virtual-puppet-slaves-with-vagrant) vagrantfile skripti esimerkistä.

Lisäsin skriptiin ajo oikeudet kaikille käyttäjille komennolla "**sudo chmod ugo+x installpuppet.sh**" jonka jälkeen kopioin tiedoston "**/usr/local/bin/**" hakemistoon seuraavalla komennolla "**sudo cp installpuppet.sh /usr/local/bin/**" . Tiedoston siirto hakemistoon  "**/usr/local/bin/**" varmistaa sen, että kaikki käyttäjät voivat ajaa sen mistä tahansa hakemistosta kutsumalla tiedoston nimen (installpuppet.sh).

## Testaus

Testasin tiedoston toimivan rinnakkais käyttäjällä "tester".

Kirjauduin käyttäjälle, avasin terminaalin ja annoin komennon "installpuppet.sh"

![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/Moduuli/pics/2.png?raw=true)

Komennon suoritus onnistui ainoa ongelma joka näkyy on "/etc/hosts" tiedoston asetusten muutokset eivät ole oikeanlaiset koska rinnakkaiskäyttäjä on samalla koneella kuin master tietokone.

Testauksen jälkeen jäin miettimään että osaamattoman käyttäjän hämmennyksen vähentämiseksi tulee poistaa ".sh" pääte komennosta jotta asennus onnistuisi luontevammin. Joten lisäsin rivin "**#!/bin/bash**" koodiin jotta linux tunnistaa sen bash skriptinä ja tämän jälkeen [nimesin "installpuppet.sh" tiedoston uudestaan](https://www.maketecheasier.com/rename-files-in-linux/) ja poistin siitä ".sh" päätteen jolloin käyttäjä saa asennettua puppetin ja halutut asetukset pelkällä "**installpuppet**" komennolla.

Lisäsin master konfigurointi skriptiini komennot jotka luo kaikille käyttäjille "**installpuppet**" komennon kun master kone konfiguroidaan.

## Kali työkalujen asennus

Mietin miten saisin mahdollisimman helposti asennettua kali työkalut ja tulin siihen lopputulokseen että ne saisi helpoiten asennutettua shelli skriptillä jonka puppet hakee master koneelta jotta saadaan varmasti oikeanlaiset asetukset asennettua.

Katselin [Toni Jääskeläisen](https://github.com/tonijaaskelainen/beginnerpentest/blob/master/Vagrantfile) opinnäytetyö skriptiä josta myös tajusin käyttää "noninteractive" komentoa kali työkalujen asennuksessa. Tutustuin tähän tarkemmin [Graham Shaw](http://www.microhowto.info/howto/perform_an_unattended_installation_of_a_debian_package.html):in kirjoittamaan opasteeseen asiasta ja päädyin käyttämään samoja komentorivejä joita Toni oli käyttänyt vagrant virtuaali koneidensa konfiguroinnissa.

Vaikka olinkin ajatellut tehdä lopullisen version shelli skriptillä päädyinkin tekemään sen packet control menetelmillä puppetilla.

Kali työkalupaketteja ei voinut ladata ilman kalin repositoreja joten piti lisätä käyttäjälle kalin repository. Tein pienen viritelmän jossa moduuli korvaa käyttäjän repository kansion annetulla kansiolla.

![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/Moduuli/pics/3.png?raw=true)

Kali repositorin lisääminen onnistui sillä ja paketit tulivat näkyviin.

![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/Moduuli/pics/4.png?raw=true)

Repository asetus muutosten jälkeen tein moduullin joka asentaa "kali-linux-full" paketin joka sentaa koko "Kali Linux" käyttöjärjestelmän työkaluja.

Päädyin siihen lopputulokseen että kalin työkaluja olisi helpompi asennuttaa olemassa olevalla työkalulla "katoolin"illa. Sitä voi käyttää asentaessa yksittäisiä työkaluja tai sitten kaikkia työkaluja mitä se tarjoaa.





## Lähteet
http://terokarvinen.com/2017/automaticaly-build-penetration-testing-environment-kali-metasploitable-vagrant

https://ask.puppet.com/question/23365/puppet-code-to-execute-bash-script/

https://github.com/tonijaaskelainen/beginnerpentest/blob/master/Vagrantfile

http://www.microhowto.info/howto/perform_an_unattended_installation_of_a_debian_package.html

https://www.maketecheasier.com/rename-files-in-linux/

https://linuxacademy.com/community/posts/show/topic/2325-error-in-connecting-puppet-master-from-puppet-agent

https://www.digitalocean.com/community/tutorials/how-to-install-puppet-4-on-ubuntu-16-04

https://ask.puppet.com/question/5373/how-to-reference-a-users-home-directory/

https://serverfault.com/questions/420749/puppet-get-users-home-directory

























































































































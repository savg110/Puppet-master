# Tehtävänanto

a) Gittiä livenä: Tee ohjeet tai skriptit, joilla saat live-USB -tikun konfiguroitua hetkessä – ohjelmat asennettua ja asetukset tehtyä.

b) Kokeile Puppetin master-slave arkkitehtuuria kahdella koneella. Liitä raporttiisi listaus avaimista (sudo puppet cert list) ja pätkä herran http-lokista (sudo tail -5 /var/log/puppet/masterhttp.log). Tee tämä alusta lähtien ja dokumentoi samalla, tunnilla aiemmin tehdyn muistelu ei riitä.

# Vastaus

![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/T2/pics/1.png)

```
sudo tail -5 /var/log/puppet/masterhttp.log
```

![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/T2/pics/2.png)

# Tietokoneen tiedot

Laitteen nimi: Asus GL752VW

Suoritin: Intel Core i7-6400 HQ CP

Näytönohjain: nVidia GeForce GTX 960M 2 Gt

RAM: 8GB

Kiintolevy: 512 Gt SSD

[xubuntu-16.04.3](http://nl.archive.ubuntu.com/ubuntu-cdimage-xubuntu/releases/16.04/release/xubuntu-16.04.3-desktop-amd64.iso) Virtuaaliympäristössä VMware® Workstation 12 Pro

### Tehtävänannossa käytetty edellisen tehtävän [T1 pohjana](https://github.com/siavonen/Puppet-master/tree/master/harjoitukset/T1)


## A) Konfigurointi skriptin luonti

Halusin tehdä skripting joka asentaisi haluamani asetukset ripeästi ja kätevästi, mutta samalla kertoen missä vaiheessa skriptiä ollaan menossa ja mitä se skriptin osa tekee.

```
echo "***************************"
echo " "
echo "Hello $USER"
echo " "
echo "***************************"

echo "---Suomenkielisen näppäimistön asettaminen---"
setxkbmap fi

echo "---Aikavyöhykkeen asettaminen Suomen aikaan---"
sudo timedatectl set-timezone Europe/Helsinki

echo "---Ohjelmisto päivitysten tarkistus ja asennus---"
sudo apt-get update

echo "---Asennetaan Git, Tree ja Puppet---"
sudo apt-get install -y git tree puppet

echo "---Luodaan git hakemisto käyttäjän koti hakemistoon---"
cd /home/$(whoami)/
mkdir git

echo "---Haetaan githubista asetukset---"
cd git
git clone https://github.com/siavonen/Puppet-master/puppet.git

echo "---Korvataan Puppetin oletus asetukset /etc/puppet hakemistossa, githubista saaduilla asetuksilla---"
sudo cp -TRv ./Puppet-master/puppet/manifests /etc/puppet

echo "---Käynnistetään Puppetin site.pp, ja asennetaan SSH daemon---"
sudo puppet apply /etc/puppet/manifests/init.pp
```

![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/T2/pics/3.png)

Puppetin asetusten korvaus komennossa käytin "cp -Rv" komentoa jotta tiedostojen päälle voidaan kirjoittaa githubista haetut tiedostot.

Tallensin CTRL + X ja save changes Y, jonka jälkeen puskin luomani install

Testasin luomani skriptiä poistamalla Git, puppet ja SSH asennukset seuraavalla komennolla

```
sudo apt-get purge -y git puppet ssh
```

Poistin "Puppet-master" hakemiston seuraavalla komennolla

```
rm -rf Puppet-master
```
Tämän jälkeen ajoin seuraavan komennon joka haki luomani "install.sh" tiedoston ja ajoi sen seuraavalla komennolla.

```
wget -O - https://raw.githubusercontent.com/siavonen/Puppet-master/installmaster | bash

```

Annettuani komennon, skripti käynnistyi ja halutut muutokset ja asennukset tehtiin.

Alla näkyy konsolissa näkyvät vaiheet "echo" kommenttien avulla

```
puppetmaster@puppetmaster:~$ wget -O - https://raw.githubusercontent.com/siavonen/Puppet-master/master/install.sh | bash
--2017-11-09 15:52:11-- https://raw.githubusercontent.com/siavonen/Puppet-master/master/install.sh
Resolving raw.githubusercontent.com (raw.githubusercontent.com)... 151.101.128.133, 151.101.192.133, 151.101.0.133, ...
Connecting to raw.githubusercontent.com (raw.githubusercontent.com)|151.101.128.133|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 941 [text/plain]
Saving to: ‘STDOUT’

- 0%[ ] 0 --.-KB/s ***************************

Hello puppetmaster

***************************
---Suomenkielisen näppäimistön asettaminen---
- 100%[========================================>] 941 --.-KB/s in 0s

2017-11-09 15:52:11 (199 MB/s) - written to stdout [941/941]

---Aikavyöhykkeen asettaminen Suomen aikaan---
---Ohjelmisto päivitysten tarkistus ja asennus---
Get:1 http://security.ubuntu.com/ubuntu xenial-security InRelease [102 kB]
Hit:2 http://us.archive.ubuntu.com/ubuntu xenial InRelease
Get:3 http://us.archive.ubuntu.com/ubuntu xenial-updates InRelease [102 kB]
Get:4 http://us.archive.ubuntu.com/ubuntu xenial-backports InRelease [102 kB]
Get:5 http://security.ubuntu.com/ubuntu xenial-security/main amd64 DEP-11 Metadata [60.3 kB]
Get:6 http://us.archive.ubuntu.com/ubuntu xenial-updates/main amd64 Packages [652 kB]
Get:7 http://security.ubuntu.com/ubuntu xenial-security/main DEP-11 64x64 Icons [62.6 kB]
Get:8 http://security.ubuntu.com/ubuntu xenial-security/universe amd64 DEP-11 Metadata [51.5 kB]
Get:9 http://security.ubuntu.com/ubuntu xenial-security/universe DEP-11 64x64 Icons [85.1 kB]
Get:10 http://us.archive.ubuntu.com/ubuntu xenial-updates/main i386 Packages [617 kB]
Get:11 http://us.archive.ubuntu.com/ubuntu xenial-updates/main amd64 DEP-11 Metadata [307 kB]
Get:12 http://us.archive.ubuntu.com/ubuntu xenial-updates/main DEP-11 64x64 Icons [227 kB]
Get:13 http://us.archive.ubuntu.com/ubuntu xenial-updates/universe amd64 Packages [543 kB]
Get:14 http://us.archive.ubuntu.com/ubuntu xenial-updates/universe i386 Packages [517 kB]
Get:15 http://us.archive.ubuntu.com/ubuntu xenial-updates/universe amd64 DEP-11 Metadata [174 kB]
Get:16 http://us.archive.ubuntu.com/ubuntu xenial-updates/universe DEP-11 64x64 Icons [245 kB]
Get:17 http://us.archive.ubuntu.com/ubuntu xenial-updates/multiverse amd64 DEP-11 Metadata [5,888 B]
Get:18 http://us.archive.ubuntu.com/ubuntu xenial-backports/main amd64 DEP-11 Metadata [3,328 B]
Get:19 http://us.archive.ubuntu.com/ubuntu xenial-backports/universe amd64 DEP-11 Metadata [4,588 B]
Fetched 3,862 kB in 8s (473 kB/s)
Reading package lists... Done
---Asennetaan Git, Tree ja Puppet---
Reading package lists... Done
Building dependency tree
Reading state information... Done
tree is already the newest version (1.7.0-3).
The following packages were automatically installed and are no longer required:
apache2-bin apache2-data apache2-utils libapr1 libaprutil1 libaprutil1-dbd-sqlite3 libaprutil1-ldap
liblua5.1-0
Use 'sudo apt autoremove' to remove them.
Suggested packages:
git-daemon-run | git-daemon-sysvinit git-doc git-el git-email git-gui gitk gitweb git-arch git-cvs
git-mediawiki git-svn puppet-el vim-puppet etckeeper
The following NEW packages will be installed:
git puppet
0 upgraded, 2 newly installed, 0 to remove and 99 not upgraded.
Need to get 0 B/3,115 kB of archives.
After this operation, 24.1 MB of additional disk space will be used.
Selecting previously unselected package git.
(Reading database ... 202744 files and directories currently installed.)
Preparing to unpack .../git_1%3a2.7.4-0ubuntu1.3_amd64.deb ...
Unpacking git (1:2.7.4-0ubuntu1.3) ...
Selecting previously unselected package puppet.
Preparing to unpack .../puppet_3.8.5-2ubuntu0.1_all.deb ...
Unpacking puppet (3.8.5-2ubuntu0.1) ...
Processing triggers for systemd (229-4ubuntu19) ...
Processing triggers for ureadahead (0.100.0-19) ...
Setting up git (1:2.7.4-0ubuntu1.3) ...
Setting up puppet (3.8.5-2ubuntu0.1) ...
Processing triggers for systemd (229-4ubuntu19) ...
Processing triggers for ureadahead (0.100.0-19) ...
---Luodaan git hakemisto käyttäjän koti hakemistoon---
mkdir: cannot create directory ‘git’: File exists
---Haetaan githubista asetukset---
fatal: destination path 'Puppet-master' already exists and is not an empty directory.
---Korvataan Puppetin oletus asetukset /etc/puppet hakemistossa, githubista saaduilla asetuksilla---
'./Puppet-master/puppet/modules/openssh/manifests/init.pp' -> '/etc/puppet/modules/openssh/manifests/init.pp'
'./Puppet-master/puppet/modules/openssh/templates/ssh_config' -> '/etc/puppet/modules/openssh/templates/ssh_config'
---Käynnistetään Puppetin init.pp, ja asennetaan SSH daemon---
Notice: Compiled catalog for puppetmaster.localdomain in environment production in 0.01 seconds
Notice: Finished catalog run in 0.02 seconds
```

Skriptin tapahtumia on helppo seurata kommenttien avulla.

Skriptin muutokset ovat seuraavanlaiset ja tässä järjestyksessä:

	1. Näppäimistöpohjan vaihtaminen Suomenkieliseen
	2. Aikavyöhykkeen vaihto Suomen aikavyöhykkeesee
	3. Ohjelmistopäivityksen tarkistus ja asennus
	4. Git, Tree ja Puppet ohjelmien asennus
	5. "Git" hakemisto luodaan käyttäjän koti hakemistoon
	6. Haetaan githubista asetukset
	7. Korvataan "puppet" ohjelmiston asetukset githubista saaduilla
	8. Käynnistetään init.pp jolla SSH daemonin asetukset asentuvat

Komentorivin tulosteiden perusteella näemme, että kaikki haluamani tapahtumat ovat menneet onnistuneesti läpi.


## B)

### Huomioi!

Puppet asetuksia asentaessa AINA käytä "sudo" oikeuksia. Muulloin konfiguroinnit yms. eivät toimi siten kun niiden kuuluisi toimia.

Luennolla käytyjen esimerkkien perusteella on parempi, että DNS asetukset asetetaan ennen muita asetuksia.


## Koneen isäntänimen (hostname) vaihto

Avasin uuden terminaalin ctrl + alt + t, ja annoin seuraavan komennon vaihtaakseni tietokoneen isäntänimen.

```
sudo hostnamectl set-hostname puppetmaster
```

puppetmasterin tilalle voi antaa minkä tahansa nimen koneelle.

Nimen vaihdon jälkeen varmistin nimen vaihdoksen komennolla

```
hostname
```

Varmistuin nimen muutoksesta, terminaalin tulosteen perusteella.

![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/T2/pics/4.png)


## Hosts tiedoston muokkaus

isäntänimen (hostname) muutoksen jälkeen tulee myös muokata muutos hosts tiedostoon jotta verkko ohjaus tapahtuu oikein.

Avasin hosts tiedoston muokattavaksi seuraavalla komennolla, ja lisäsin tiedostoon "puppetmaster" nimikkeen jonka asetin aikaisemmin käyttäjänimen perään hosts tiedostossa.

```
sudoedit /etc/hosts
```
![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/T2/pics/5.png)

Asetusten muokkauksen jälkeen testasin yhteyden saannin asettamaani "puppetmaster":iin seuraavalla komennolla. Rajasin "-c 4" komento lisäkkeellä testi tapahtuman neljään testiin jonka jälkeen testi loppuu.

![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/T2/pics/6.png)

Testin lopputuloksena huomaan yhteyden toimivan "puppetmaster" osoitteeseen.



## [Avahi demoni](https://linux.die.net/man/1/avahi-browse)

localhost nimen käyttöönotto (että yhteydenotto toimi toisesta koneesta lisäämällä nimen jälkeen ” puppetmaster.local” ) avahi-daemon on nimipalvelun määrittävä sovellus oletuksena asennettuna linux/mac käyttöjärjestelmiin.

Jotta localhost nimen käyttöönotto tulee voimaan tulee käynistää avahi uudestaan, ja se tapahtuu seuraavalla komennolla.

```
sudo service avahi-daemon restart
```

Uudelleen käynistyksen jälkeen testasin yhteyden samalla tavalla kun aikaisemmin "puppetmaster" hostname testatessa.

```
ping -c 4 puppetmaster.local
```

![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/T2/pics/7.png)

## Puppetmaster asennus

Asensin puppetmasterin seuraavalla komennolla

```
sudo apt-get -y install puppetmaster
```

Asennuksen jälkeen tarkistin puppet ohjelman sertifikaatit seuraavalla komennolla

```
sudo ls /var/lib/puppet/ssl/certs
```

![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/T2/pics/8.png)

Sertifikaatti listasta tarvitsen "puppetmaster.localdomain.pem" ja tarkistan sen DNS aseutkset seuraavalla komennolla.

```
sudo openssl x509 -in /var/lib/puppet/ssl/certs/puppetmaster.localdomain.pem -text|less
```

Rivillä "X509v3 Subject Alternative Name" käy ilmi, että DNS asetukset eivät ole asettuneet täysin oikein sertifikaattiin. Se tulee poistaa jotta vältytään puppetmaster ja puppetin välillä.

![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/T2/pics/9.png)

## [Grep komennolla etsiminen](https://people.uta.fi/~jm58660/jutut/unix/grep.html)

Grep komennon avulla voimme helposti ja kätevesti tarkistaa juuri sen rivin tiedot mitä haluamme katsella ja se tapahtuu seuraavalla komennolla.

```
sudo openssl x509 -in /var/lib/puppet/ssl/certs/puppetmaster.localdomain.pem -text|grep -i DNS
```

Lopputulos on seuraavanlainen

![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/T2/pics/10.png)

## Virheellisten sertifikaattien poisto ja uusien konfigurointi

### HUOMIOI!

Sertifikaatteja EI saa poistaa kun on luotu yhteys orja koneeseen. Se luo yhteydenluonti ongelmia, luottamus syistä.



Ensiksi tulee pysäyttää puppetmaster ohjelma jotta sertifikaatteja voi muokata, ja se tapahtuu seuraavalla komennolla.

```
sudo service puppetmaster stop
```

Pysäytettyäni puppetmaster ohjelman, editoidaan puppet ohjelmiston konfiguraatio seuraavalla komennolla.

```
sudoedit /etc/puppet/puppet.conf
```

edirotin auettua kirjoitetaan seuraava rivi [master] konfigurointien alle ilmoitetaan DNS nimitykset jotka tässä tapauksessa ovat "puppetmaster" ja "puppetmaster.local"


![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/T2/pics/11.png)

Muutosten jälkeen tallensin ctrl + x, save modified buffer? Y, enter.


Konfiguraatio muutosten jälkeen siirryin poistamaan virheellisen sertifikaatin.

__Huomioi että sertifikaatteja poistaessa kaikki puppetin sertifikaatit tulee poistaa!__

Näin ollen poistin setifikaatteja sisältävän tiedoston sisältöineen seuraavalla komennolla.

```
sudo rm -r /var/lib/puppet/ssl/
```

Poiston jälkeen käynnistetään puppetmaster jotta se generoisi uudet ja toimivat sertifikaatit. Käynnistys tapahtuu seuraavalla komennolla.

```
sudo service puppetmaster start
```

Käynnistettyä puppetmasterin voin tarkistaa DNS asetusten oikeellisuuden sertifikaatista aikaisemmin mainitulla "grep" komennolla.

```
sudo openssl x509 -in /var/lib/puppet/ssl/certs/puppetmaster.localdomain.pem -text|grep -i DNS
```

![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/T2/pics/12.png)

grep komennon tulosteen avulla näen että DNS asetukset ovat asettuneet oikein sertifikaattiin.

## Orja koneen konfigurointi

Ensiksi asensin puppet ohjelmiston komennolla

```
sudo apt-get -y install puppet
```

Asennettua puppet ohjelmiston, muokataan sen konfigurointi seuraavalla komennolla.

```
sudoedit /etc/puppet/puppet.conf
```

Konfiguraatioiden alapuolelle määritetään [agent] asetukset jossa määritellään master tietokoneen tiedot johon orja yhdistäytyy.

![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/T2/pics/13.png)

Orjakoneen käyttöönotto jokaisella orjakoneella tapahtuu seuraavalla komennolla

```
sudo puppet agent --enable

sudo puppet agent --test
```

## Orjakoneen lisääminen masterkoneessa

Orjakoneet jotka haluavat kuulua orja verkostoon näkyvät sertifikaatti listalla jonka saadaan näkyviin seuraavalla komennolla.

```
sudo puppet cert --list
```

![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/T2/pics/14.png)

Listattua sertifikaatit huomasin että slave01 kone tuli näkyviin ja hyväksyin sen orjaksi verkostooni seuraavalla komennolla.

```
sudo puppet cert --sign slave01
```

![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/T2/pics/15.png)

## Koneiden välisen yhteyden testaaminen

Siirryin puppet hakemistoon seuraavalla komennolla

```
cd /etc/puppet
```

Loin puppet hakemistossa olevaan modules hakemistoon "hello/manifests"  hakemiston seuraavalla komennolla

```
sudo mkdir -p modules/hello/manifests/
```

Hakemiston luotua loin "site.pp" tiedoston manifests hakemistoon (/etc/puppet/manifests/) seuraavalla komennolla

```
sudoedit manifests/site.pp
```

Luotuani tiedoston kirjoitin sinne "include hello" joka tarkoittaa, että orjalle välitetään "hello" kansiossa olevat moduulit

![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/T2/pics/16.png)

Tallensin CTRL + X, save cheanges? Y ja enter

## Hello moduulin luonti

helloworld moduulin luoti tapahtuu seuraavalla komennolla

```
sudoedit modules/hello/manifests/init.pp
```

luotuani tiedoston, syötän sinne seuraavan koodin joka luo väliaikais tiedoston orjalle ja sisällyttää seuraavan tekstin "Hello my agent"

```
class hello {
	file { '/tmp/masterSpeaks':
	content => "Hello my agent\n"
	}
}
```

![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/T2/pics/17.png)

## Hakemistot näyttävät seuraavanlaiselta Tree demonin avulla

![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/T2/pics/18.png)

## Manifestin hakeminen orja koneella

Luotujen manifestien hakeminen orja tietokoneella tapahtuu seuraavalla komennolla.

```
sudo puppet agent --test --verbose
```

![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/T2/pics/19.png)

Manifestien haun jälkeen tarkistetaan, että se toimi oikein seuraavalla komennolla

```
cat /tmp/masterSpeaks
```

![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/T2/pics/20.png)

## [Runinterval ja sen konfigurointi](https://ask.puppet.com/question/2451/how-do-you-change-the-runinterval/)

Runinterval eli tiedostojen haku masterilta tapahtuu automaattisesti joka 1800 sekunti (3omin). Tämän voi muokata orja tietokoneessa /etc/puppet/puppet.conf tiedostosta seuraavanlaisesti

Siirrytään hakemistoa muokkaamaan seuraavalla komennolla

```
sudoedit /etc/puppet/puppet.conf
```

Kirjoitetaan seuraava rivi [agent] konfiguraatioiden alapuolelle jotta saadaan tiedon haku sillä aikataululla kun halutaan.

```
runinterval = 10
```

jolloin orja hakee master tietokoneelta sille jaetut tiedostot joka 10 sekunti

![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/T2/pics/21.png)

Muutosten jälkeen CTRL + X, save changes? Y ja enter.

Tallennettuani muutokset tarkistin että se on tallentunut oikein, seuraavalla komennolla

```
sudo puppet agent --configprint runinterval
```

![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/T2/pics/22.png)

## Lähteet

http://terokarvinen.com/2012/puppetmaster-on-ubuntu-12-04

http://terokarvinen.com/2012/puppetmaster-on-ubuntu-12-04#comment-21939

http://terokarvinen.com/2017/simpler-puppet-manifests-resource-defaults-and-manifest-ordering

https://github.com/poponappi/essential-tools

https://stackoverflow.com/questions/8488253/how-to-force-cp-to-overwrite-without-confirmation


# Tehtävänanto

a) Asenna useita orjia yhteen masteriin. Ainakin yksi rauta- ja useampia virtuaalisia orjia.

b) Kerää tietoa orjista: verkkokorttien MAC-numerot, virtuaalinen vai oikea… (Katso /var/lib/puppet/)

c) OrjaSkripti: Tee skripti, joka muuttaa koneen Puppet-orjaksi tietylle masterille. Voit katsoa mallia Tatun tai Eemelin ratkaisuista.

d) (vapaaehtoinen) Laita skripti Vagrantfile:n provisointiskriptiksi.

e) Vapaaehtoinen: Oikeaa elämää. Ratkaise jokin kurssin ulkopuolinen asia Puppetilla.

f) Vapaaehtoinen: Unelmien tikku. Tee unelmiesi USB-live-tikku.



# Tietokoneen tiedot

Laitteen nimi: Dedicated server

Suoritin: AMD FX(tm)-8350 Eight-Core Processor

Näytönohjain: integroitu

RAM: 32GB

Kiintolevy: 1 TB HHD

Linux 4.10.0-38-generic x86_64

### Tehtävässä käytetty edellisen tehtävän [T2 pohjana](https://github.com/siavonen/Puppet-master/tree/master/harjoitukset/H2)


Ensiksi otin yhteyden palvelimeeni syöttämällä SSH yhteyden luontiin tarvittavat tiedot. Komento on seuraavanlainen

```
ssh käyttäjä@palvelimen_IP
```

### Kuvakaappaus vältetty turvallisuus syistä.

## Vagrantin ja vritual boxin asennus

Aijemmissa harjoituksissa asensin tunnilla käytyjen ohjeistuksien mukaan jotka myös löysin teron sivuilta, asensin vagrantin ja virtualboxin.

## "nilClass" virheilmoituksen poisto

site.pp kansioon joka löytyy hakemistosta "/etc/puppet/manifests/site.pp/" lisätään seuraava koodi pätkä joka kertoo puppet ohjelmalle, mikäli luokkaa tai moduulia ei löydy puppet tarkastaa oletuksena tämän koodi pätkän sisällä olevaa moduulia.

Muokkasin tiedostoa seuraavalla komennolla

```
sudoedit /etc/puppet/manifests/site.pp
```

Jonka jälkeen lisäsin seuraavan koodi pätkän tiedostoon


```
node default {
	#Koodi tulee tähän
} 
```

Tallensin muutokset CTRL + X, save changes? Y ja enter

## [Vagrantfile](https://www.vagrantup.com/docs/vagrantfile/tips.html) määritykset ja skriptin luonti

Muokkasin "Vagrantfile" määrityksiä seuraavalla komennolla

```
nano Vagrantfile
```

Avattuani "Vagrantfile" tiedoston poistin sen sisällön CTRL + K pohjassa pitämällä. Tämän jälkeen liitin tiedostoon alla olevan skriptin.

[set -o -v](https://www.computerhope.com/unix/uset.htm) tulostaa käytettyjä komentoja kun niitä ajetaan.

[||](https://unix.stackexchange.com/questions/24684/confusing-use-of-and-operators) “joko tai”  yritää suorittaa komentoja niiden anto järjestyksessä mikäli edellinen ei onnistunut.

[“echo -e”](https://www.computerhope.com/unix/uecho.htm) echo tulostaa tekstiä terminaaliin ja -e sallii \ \n \* käytön komennossa.

[“tee -a”](https://www.computerhope.com/unix/utee.htm) komennot lukee T mäisesti tässä tapauksessa vasemmalta tekstin joka on luotu echo:lla ja kopioi sen määrättyyn tiedostoon “-a” estää ylikirjoituksen.

[grep “^”](https://www.computerhope.com/unix/ugrep.htm) etsii tekstiä missä tahansa rivillä, joka on ensimmäisenä rivillä.

Alla oleva skripti on [Tero Karvisen](http://terokarvinen.com/2017/provision-multiple-virtual-puppet-slaves-with-vagrant) luoma skripti joka on muokattu tämän tehtävän ratkaisua varten

```
$tscript = <<TSCRIPT
set -o verbose
apt-get update
apt-get -y install puppet
grep ^server /etc/puppet/puppet.conf || echo -e "\n[agent]\nserver=puppetmaster\n" |sudo tee -a /etc/puppet/puppet.conf
grep puppetmaster /etc/hosts || echo -e "\n192.168.223.134 puppetmaster\n"|sudo tee -a /etc/hosts
sudo puppet agent --enable
sudo puppet agent --test
sudo service puppet start
sudo service puppet restart
TSCRIPT

Vagrant.configure(2) do |config|

 config.vm.box = "bento/ubuntu-16.04"
 config.vm.provision "shell", inline: $tscript

 config.vm.define "slave01" do |slave01|
 slave01.vm.hostname = "slave01"
 end

 config.vm.define "slave02" do |slave02|
 slave02.vm.hostname = "slave02"
 end

 config.vm.define "slave03" do |slave03|
 slave03.vm.hostname = "slave03"
 end
end
```

![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/H3/pics/1.png?raw=true)

Syötettyäni skriptin tallensin CTRL + X ja save changes? Y ja enter

## Vagrant koneiden käynnistys Vagrantfile tiedostosta

Seuraavalla komennolla käynnistin "Vagrantfile" tiedostossa olevan skriptin joka luo slave01, slave02 ja slave 03 virtuaali tietokoneet ja asentaa skriptin mukaisesti tarvittavat asennukset ja konfiguraatio muutokset puppet konfiguraatio tiedotoon.

```
vagrant up
```

Virtuaalikoneiden luonti jokaiseen koneen kohdalla näytti tältä

## slave01

![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/H3/pics/2.png?raw=true)

## slave02

![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/H3/pics/3.png?raw=true)

## slave03

![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/H3/pics/4.png?raw=true)

# Slave01 koneen testaus

Otin yhteyden "slave01" virtuaali koneeseen seuraavalla komennolla

```
vagrant ssh slave01
```

![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/H3/pics/5.png?raw=true)

SSH yhteys onnistui

## Sertifikaattien hyväksyttäminen

Tarkistin orja koneiden sertifikaatit ja hyväksyin ne seuraavilla komennoilla

```
sudo puppet cert --list

sudo puppet cert --sign -a
```

![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/H3/pics/6.png?raw=true)

## Uusi puppet moduuli ja sen testaus

Loin uuden moduuli hakemiston seuraavalla komennolla

```
sudo mkdir /etc/puppet/modules/tree/manifests
```

jonka jälkeen loin manifests kansioon "init.pp" tiedoston jonne syötin uuden moduulin, seuraavalla komennolla ja se näytti seuraavanlaiselta

```
sudoedit /etc/puppet/modules/tree/manifests/init.pp
```

![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/H3/pics/7.png?raw=true)

Tallensin tiedoston CTRL + X ja save changes Y ja enter

## Site.pp tiedostoon node lisäys

site.pp tiedoston muokkaus tapahtuu seuraavalla komennolla

```
sudoedit /etc/puppet/manifests/site.pp
```

![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/H3/pics/8.png?raw=true)

Tallensin muutokset CTRL + X, save changes? Y ja enter

## Testaus

Testasin site.pp määritystä "slave01" orja koneessa seuraavilla komennoilla

```
sudo puppet agent --test --verbose

cat /tmp/tree
```

![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/H3/pics/9.png?raw=true)

Testi onnistui, tree demoni on asentunut "slave01" orja koneelle ja ohjeistukset siitä on myös mennyt perille.

## MAC osoitteiden katselu

Puppetin orjien mac osoitteita voi tarkastella seuraavasta hakemistosta "/var/lib/puppet/yaml/node" mutta siihen tarvitaan sudo oikeudet jotta niitä voi tarkastella. Ensiksi katsoin mitä tiedostoja hakemistossa on jonka jälkeen tarkistin virtuaali orjien mac osoitteet ja kohdistin tarkistuksen "mac" sanaa sisältäviin riveihin. Tämä tapahtui seuraavilla komennoilla.

```
sudo ls /var/lib/puppet/yaml/node

sudo grep -i mac /var/lib/puppet/yaml/node/slave01.yaml
```

![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/H3/pics/10.png?raw=true)

Yllä olevassa kuvakaappauksessa näkyy virtuaali koneiden mac osoitteet. Ne ovat samat koska ne ovat saman virtuaali ohjelmiston alaisena ja näin ollen ne pyörivät samassa mac ympäristössä.

Tarkistin puppetmaster rautaorjan mac osoitteen, saman kaltaisesti kun virtuaalikoneiden mac osoitteita tarkistaessa.

```
sudo grep -i mac /var/lib/puppet/yaml/node/puppetmaster.yaml
```

![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/H3/pics/11.png?raw=true)

## Lähteet
http://terokarvinen.com/2017/aikataulu-linuxin-keskitetty-hallinta-3-op-vanha-ops-%E2%80%93-loppusyksy-2017-p5-puppet

http://terokarvinen.com/2017/provision-multiple-virtual-puppet-slaves-with-vagrant

http://terokarvinen.com/2017/multiple-virtual-computers-in-minutes-vagrant-multimachine

https://www.vagrantup.com/docs/vagrantfile/tips.html

https://en.wikipedia.org/wiki/Here_document#Unix_shells

https://stackoverflow.com/questions/2500436/how-does-cat-eof-work-in-bash

https://guichlyhessen.wordpress.com/2017/11/15/t3-vagrantilla-slave-koneiden-konfigurointia/

### Kommenot
https://unix.stackexchange.com/questions/24684/confusing-use-of-and-operators

https://www.computerhope.com/unix/uset.htm

https://www.computerhope.com/unix/uecho.htm

https://www.computerhope.com/unix/utee.htm

https://www.computerhope.com/unix/ugrep.htm




















































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
















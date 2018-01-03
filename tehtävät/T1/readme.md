# Tehtävänanto

a) Asenna jokin muu demoni kuin Apache. Raportoi, miten rakensit, selvitit ja testasit kunkin osan (esim. sudo puppet resource, puppet describe, lähteet…). Julkaise myös modulisi lähdekoodi niin, että sen voi helposti ottaa käyttöön.

## Laitteen tiedot

Laitteen nimi: Asus GL752VW

Suoritin: Intel Core i7-6400 HQ CP

Näytönohjain: nVidia GeForce GTX 960M 2 Gt

RAM: 8GB

Kiintolevy: 512 Gt SSD

xubuntu-16.04.3 Virtuaaliympäristössä VMware® Workstation 12 Pro

### Puppet Asennus

Avasin terminaalin pikanäppäimillä CTRL + ALT + T ja tämän jälkeen syötin seuraavan komennon joka ensiksi päivittää tietokoneen tietolähteet (repository), tämän jälkeen asennetaan puppet ohjelmisto ja sen lisäksi tree demoni jonka avulla voi visualisoida hakemistojen rakennetta paremmin ja helpommin.

```
sudo apt-get update && sudo apt-get -y install puppet && sudo apt-get -y install tree
```

Tietolähteiden päivityksen, puppet ohjelmiston ja tree demonin asennusten jälkeen puppet ohjelmistoa voidaan testata. Seuraavalla komennola saadaan näkyviin puppet ohjelmiston versio.

```
puppet --version
```

![alt text](https://github.com/siavonen/Puppet-master/blob/master/teht%C3%A4v%C3%A4t/T1/pics/1.png?raw=true)

### Manifest Ordering

Käytännössä tarkoittaa sitä että koodia luetaan ylhäältä alas ja tämä helpottaa huomattavasti koodin kirjottamista että sen lukemista. Tämä onnistuu kun muutetaan puppet ohjelmiston konfiguraatiota seuraavalla komennolla.

```
sudo nano /etc/puppet/puppet.conf
```

Konfiguraatio tiedostoon tulee kirjoittaa seuraavanlaisesti rivin 9 alapuolelle.

```
ordering = manifest
```

![alt text](https://github.com/siavonen/Puppet-master/blob/master/teht%C3%A4v%C3%A4t/T1/pics/2.png?raw=true)

Muutosten jälkeen tallensin konfiguraation CTRL + X ja save changes Y


### Puppet hakemistot ja niiden luominen

Konfiguroinnin jälkeen loin manifest ja templates kansiot seuraavanlaisesti

Navigoin puppet modules hakemistoon seuraavalla komennolla

```
cd /etc/puppet/modules
```

Loin modules hakemistoon "openssh" kansion seuraavalla komennolla

```
sudo mkdir openssh
```

Navigoin luomaani kansioon seuraavalla komennolla

```
cd openssh
```

Loin hakemistot manifests ja templates navigoimaani hakemistoon seuraavilla komennoilla

```
sudo mkdir manifests

sudo mkdir templates
```

Luotuani hakemistot katselin niitä seuraavilla komennoilla

```
tree
pwd
ls
```

![alt text](https://github.com/siavonen/Puppet-master/blob/master/teht%C3%A4v%C3%A4t/T1/pics/3.png?raw=true)

## SSH puppet tiedoston luonti


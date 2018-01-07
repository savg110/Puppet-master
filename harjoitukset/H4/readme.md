# Tehtävänanto

a) Unelmien työpöytä. Konfiguroi graafinen ja komentirivikäyttöliittymä Puppetilla. Asenna tarvittavat ohjelmat ja niihin säädöt.

Vinkki: Kannattaa ryhtyä käyttämään Puppettia päivittäin. Voit säätää Puppetilla jokapäiväistä työpöytääsi, jolloin varmuus ja kokemus Puppetista kehittyy.

Vinkki: Samat säädöt saat kotiin, läppärille ja hetkessä livetikulle vaikkapa Gitillä.



# Tietokoneen tiedot

Laitteen nimi: Dedicated server

Suoritin: AMD FX(tm)-8350 Eight-Core Processor

Näytönohjain: integroitu

RAM: 32GB

Kiintolevy: 1 TB HHD

Linux 4.10.0-38-generic x86_64

### Tässä harjoituksessa käytin edellisen harjoituksen [H3](https://github.com/siavonen/Puppet-master/tree/master/harjoitukset/H3) master koneen konfiguraatioita.

## Bash komento muutosten testailua

Katselin etistä esimerkkejä käyttäjän asetuksia muuttaessa .bashrc tiedostoa muokkaamalla joka aiheuttaa asetus muutoksia käyttäjällä. Tämän jälkeen kirjauduin sisään palvelimelleni seuraavalla komennolla.

```
ls -a
```

![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/H4/pics/1.png?raw=true)

Löysin komennolla .bashrc tiedoston jonka jälkeen muokkasin sitä ja lisäsin [stackoverflowista](https://superuser.com/questions/60555/show-only-current-directory-name-not-full-path-on-bash-prompt) löydetyn muokkaus koodin joka muokkaa käyttäjän terminaalin värejä.

Muokkasin .bashrc tiedoston seuraavalla komennolla:

```
nano .bashrc
```


Tiedoston avattua selasin koodin loppuun "pgdn" näppäimellä ja lisäsin koodin loppuun seuraavan rivin koodia.

![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/H4/pics/2.png?raw=true)

Tallensin muutoksen CTRL + X ja save changes? Y ja enter

Muutosten jälkeen suljin SSH yhteyden "exit" komennolla ja otin yhteyden uudestaan, jotta muutokset astuisivat voimaan.

![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/H4/pics/3.png?raw=true)

Huomasin konsoli tekstien värin muutoksen samantien kirjautumisen jälkeen jonka jälkeen testasin tiedostojen katselu komentoa varmistaakseni muutoksen.

```
ls -a
```

![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/H4/pics/4.png?raw=true)

Testaus paljasti muutosten toimivan niinkuin pitääkin.

## Käyttäjämuutosten jako muille käyttäjille

Testausten onnistumisen jälkeen halusin laittaa asetukset muillekin käyttäjille. Tämä vaatii .bashrc tiedoston "etc/skel" hakemistoon kopioimisen. Kaikki käyttäjät saavat oletus asetuksensa sieltä hakemistosta.

Kopioiminen tapahtui seuraavalla komennolla:

```
sudo cp .bashrc /etc/skel/
```

Annetua komennon kysyttiin ylläpidon salasanaa, annoin salasanan ja komento meni läpi.

Tarkistin kopioinnin tarkastelemalla "/etc/skel/" hakemiston ".bashrc" tiedostoa seuraavalla komennolla.

```
cat /etc/skel/.bashrc
```
![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/H4/pics/5.png?raw=true)

Huomasin että lisäämäni viimeinen rivi on siirtynyt oletus asetuksiin ja näin ollen kaikki on mennyt niinkuin pitikin.



## Uuden käyttäjän testaus

Loin uuden käyttäjän komennolla "adduser" ja annoin käyttäjälle nimen "testi"

```
adduser testi
```

![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/H4/pics/6.png?raw=true)

Luotuani käyttäjän avasin, loin uuden SSH yhteyden luomaani "testi" käyttäjään ja huomasin asetusten tullen myös voimaan sille.

![alt text](https://github.com/siavonen/Puppet-master/blob/master/harjoitukset/H4/pics/7.png?raw=true)

## Shell skriptien testailua

Shell skriptien avulla voidaan luoda skripti joka ajaa monta komentoa peräkkäisesti ja tulostaa lopputuloksen terminaaliin. Skriptin käyttö oikeuksia voidaan yleistää jotta siitä tulee jonkin niminen komento.

Loin skriptin "Huomenta" seuraavalla komennolla

```
puppetmaster:~$ nano Huomenta
```

Kirjoitin bash skriptin seuraavasti

*date* tulostaa päivämäärän ja kellon ajan

*ping* testaa yhteyden google.com:in välillä ja tulostaa kuinka monta pakettia hukattiin yhteydenotossa

*facter* tarkistaa paikallisen IP osoitteen

```
#!/bin/bash

date --iso=min

ping -c 1 google.com|grep loss

facter ipaddress
```

Tallensin skriptin CTRL + X, save changes? Y ja enter

Testasin skriptiä seuraavalla komennolla

```
bash ./Huomenta
```









































































































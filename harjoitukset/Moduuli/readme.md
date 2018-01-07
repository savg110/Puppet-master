# Tavoite
Tavoitteena on saada valmiiksi skripti joka varmistaa kali työkalujen asentumisen helposti uudelle työpöytä alustalle.



# Aloitus
Alkuun katsoin Tero Karvisen sivuilla mainitun opinnäytetyön joka kohdistuu nimenomaan kali työkalujen asennukseen linux pohjaiseen työpöytään.

Tulin siihen lopputulokseen että en voi käyttää kyseistä asennus skriptiä moduuilissani mutta kuitenkin pystyin käyttämään osan siitä joka asentaa kali ohjelmiston halutulle koneelle.

Muokkasin T2 käytettyä bash skriptiä siten, että se asentaa käyttäjälle tree demonin ja puppetin. Lisäksi skripti muokkaa puppetin konfiguraatio tiedostoja ja määrittää master serverin ja myös määrittää master serverin "/etc/hosts" tiedostossa. Tätä skriptiä tullaan käyttämään orjakoneella.
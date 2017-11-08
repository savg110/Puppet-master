echo "***************************"
echo " "
echo "Hello $USER"
echo " "
echo "***************************"

echo "---Suomenkielisen näppäimistön asettaminen---"
setxkbmap fi

echo "---Ohjelmisto päivitysten tarkistus ja asennus---"
sudo apt-get update

echo "---Asennetaan Git, Tree ja Puppet---"
sudo apt-get install -y git tree puppet

echo "---Luodaan git hakemisto käyttäjän koti hakemistoon---"
cd /home/$(whoami)/
mkdir git

echo "---Haetaan githubista asetukset---"
cd git
git clone https://github.com/siavonen/Puppet-master.git

echo "---Korvataan Puppetin oletus asetukset /etc/puppet hakemistossa, githubista saaduilla asetuksilla---"
sudo cp -TRv ./Puppet-master/puppet/manifests /etc/puppet

echo "---Käynnistetään Puppetin init.pp, ja asennetaan SSH daemon---"
sudo puppet apply /etc/puppet/manifests/modules/openssh/manifests/init.pp

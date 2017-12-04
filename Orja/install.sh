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

echo "---Asennetaan Tree ja Puppet---"
sudo apt-get install -y tree puppet

echo "---Muokataan Puppet asetuksia---"
sudo grep ^server /etc/puppet/puppet.conf || echo -e "\n[agent]\nserver=puppetmaster\n" |sudo tee -a /etc/puppet/puppet.conf

echo "--Muokatan /etc/hosts/ asetuksia--"
sudo grep puppetmaster /etc/hosts || echo -e "\n192.168.223.134 puppetmaster\n"|sudo tee -a /etc/hosts

echo "--Puppetin käynnistys--"
sudo puppet agent --enable
sudo puppet agent --test
sudo service puppet start
sudo service puppet restart
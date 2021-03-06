#Desktop
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-cache policy docker-ce

#Also xenial for old Docker version for running Minikube locally 
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu cosmic stable"

apt-get update
apt-get -y install terminator firefox jq aptitude apt-transport-https ca-certificates gnupg2 curl software-properties-common docker-ce docker-compose libxss1 libgconf2-4 evince socat maven openjdk-8-jdk
aptitude -y install --without-recommends ubuntu-desktop 
#Fix root not allowed to start X-window
xhost local:root

#developer user
useradd -d /home/developer -m developer
echo -e "Welcome01\nWelcome01" | passwd developer
usermod -a -G vboxsf developer
usermod -a -G docker developer
usermod -a -G sudo developer
usermod --shell /bin/bash developer

#Fix screen flickering issue
perl -e '$^I=".backup";while(<>){s/#(WaylandEnable=false)/$1/;print;}' /etc/gdm3/custom.conf

#Hide vagrant
echo '[User]' > /var/lib/AccountsService/users/vagrant
echo 'SystemAccount=true' >> /var/lib/AccountsService/users/vagrant

cp /etc/sudoers.d/vagrant /etc/sudoers.d/developer
sed -i 's/vagrant/developer/g' /etc/sudoers.d/developer

#Node
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
apt-get install -y nodejs

#Postman
wget https://dl.pstmn.io/download/latest/linux64 -O /tmp/postman.tar.gz
sudo tar -xzf /tmp/postman.tar.gz -C /opt
rm /tmp/postman.tar.gz
sudo ln -s /opt/Postman/Postman /usr/bin/postman

apt-get autoremove
apt-get clean

shutdown now -h

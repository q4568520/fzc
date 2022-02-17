#!/bin/bash
sudo -i

sudo curl -fsSL -o /usr/share/keyrings/salt-archive-keyring.gpg https://repo.saltproject.io/py3/ubuntu/20.04/amd64/latest/salt-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/salt-archive-keyring.gpg arch=amd64] https://repo.saltproject.io/py3/ubuntu/20.04/amd64/latest focal main" | sudo tee /etc/apt/sources.list.d/salt.list
apt-get update

if [ `hostname` == 'salt-minion' ]
then
  apt-get install salt-minion -y
  sed -i 's/\#master:\ salt/master:\ 192.168.56.20/g' /etc/salt/minion
  systemctl restart salt-minion
else
  apt-get install salt-master salt-minion -y
  sed -i 's/\#master:\ salt/master:\ 192.168.56.20/g' /etc/salt/minion
  systemctl restart salt-minion
fi

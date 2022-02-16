#!/bin/bash
sudo -i

sudo curl -fsSL -o /usr/share/keyrings/salt-archive-keyring.gpg https://repo.saltproject.io/py3/ubuntu/20.04/amd64/latest/salt-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/salt-archive-keyring.gpg arch=amd64] https://repo.saltproject.io/py3/ubuntu/20.04/amd64/latest focal main" | sudo tee /etc/apt/sources.list.d/salt.list

apt-get update
apt-get install salt-minion -y
systemctl start salt-minion && systemctl enable salt-minion
sed -i 's/\#master:\ salt/master:\ 192.168.56.21/g' /etc/salt/minion
systemctl restart salt-minion

if [ `hostname` == 'salt1' ]; then
apt-get install salt-master
systemctl start salt-master && systemctl enable salt-master
salt-key -A -y
salt-key -L
salt \* test.ping
fi

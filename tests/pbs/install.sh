#!/bin/bash
sudo useradd -r -c "PBS data service management account" pbsdata
wget https://vcdn.altair.com/rl/OpenPBS/openpbs_23.06.06.ubuntu_20.04.zip
sudo apt-get install unzip libhwloc15 libical3 libpq5 munge
unzip openpbs_23.06.06.ubuntu_20.04.zip
sudo dpkg -i openpbs_23.06.06.ubuntu_20.04/openpbs-server_23.06.06-1_amd64.deb
sudo create-munge-key
sudo ln -s /lib64/libmunge.so.2 /lib64/libmunge.so
sudo sed -i 's/PBS_START_MOM=0/PBS_START_MOM=1/g' /etc/pbs.conf
sudo systemctl restart pbs

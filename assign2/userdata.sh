 #! /bin/bash
sudo apt install update
sudo apt install apache2 -y
sudo mkfs -t ext4 /dev/xvdf
sudo mount /dev/xvdf /var/www/html

#!/bin/bash
echo "Adding apt-keys"
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

echo "Updating apt"
sudo apt update

echo "Installing jenkins"
sudo apt install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins

sleep 5

echo " "
echo " "
echo "### Inicial Admin Password ##"
echo " "
echo " "
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
echo " "
echo " "
echo "#############################"
echo " "
echo " "

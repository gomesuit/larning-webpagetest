#!/bin/bash
set -e

# install nodejs
#curl -L git.io/nodebrew | perl - setup
#echo 'export PATH=$HOME/.nodebrew/current/bin:$PATH' >> .bash_profile
#source ~/.bash_profile
#nodebrew install-binary v6.9.5
#nodebrew use v6.9.5


# install dependency package
sudo yum install -y vim wget net-tools unzip

# install epel package
sudo yum install -y epel-release

# install nginx
sudo yum install -y nginx

# install php-fpm
sudo rpm -Uvh /vagrant/settings/remi-release-7.rpm
#sudo yum install -y php56-php-fpm php56-php-mysqlnd php56-php-mbstring
sudo yum install -y php56-php-fpm php56-php-mbstring

# setting nginx
sudo rm -f /etc/nginx/nginx.conf
sudo ln -s /vagrant/settings/nginx.conf /etc/nginx/nginx.conf
sudo ln -s /vagrant/settings/webpagetest.conf /etc/nginx/conf.d/webpagetest.conf
#sudo chown nginx.nginx /etc/nginx/nginx.conf /etc/nginx/conf.d/webpagetest.conf

# setting php-fpm
sudo sed -i -e 's/user = apache/user = nginx/g' /opt/remi/php56/root/etc/php-fpm.d/www.conf
sudo sed -i -e 's/group = apache/group = nginx/g' /opt/remi/php56/root/etc/php-fpm.d/www.conf

# start daemon
sudo systemctl start nginx
sudo systemctl start php56-php-fpm



wget https://github.com/WPO-Foundation/webpagetest/archive/WebPageTest-3.0.tar.gz
tar zxfv WebPageTest-3.0.tar.gz
sudo cp -r webpagetest-WebPageTest-3.0/www /usr/share/nginx/


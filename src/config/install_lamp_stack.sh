#!/bin/bash



# Install Apache
# sudo yum install -y httpd httpd-tools mod_ssl
# sudo systemctl enable httpd 
# sudo systemctl start httpd


# # Install Mysql

# sudo rpm -Uvh https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
# sudo yum install mysql-community-sesrver -y
# sudo mysql57-server php72-mysqlnd
# sudo systemctl enable mysqld
# sudo systemctl start mysqld

# sudo rpm -Uvh https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
# sudo yum install mysql-community-server -y
# sudo yum install mysql57-server php72-mysqlnd -y
# sudo systemctl enable mysqld
# sudo systemctl start mysqld


# # Install PHP

# sudo amazon-linux-extras enable php7.2
# sudo yum clean metadata
# sudo yum install php php-common php-pear -y
# sudo yum install php-{cgi,curl,mbstring,gd,mysqlnd,gettext,json,xml,fpm,intl,zip} -y

# # permission

# sudo usermod -a -G apache ec2-user
# sudo chown -R ec2-user:apache /var/www
# sudo chmod 2775 /var/www && find /var/www -type d -exec sudo chmod 2775 {} \;
# sudo find /var/www -type f -exec sudo chmod 0664 {} \;
# chown apache:apache -R /var/www/html 



sudo apt update
sudo apt install apache2 \
                 ghostscript \
                 libapache2-mod-php \
                 mysql-server \
                 php \
                 php-bcmath \
                 php-curl \
                 php-imagick \
                 php-intl \
                 php-json \
                 php-mbstring \
                 php-mysql \
                 php-xml \
                 php-zip


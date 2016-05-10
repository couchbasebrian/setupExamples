#!/bin/bash
# setupExamples.sh
# Brian Williams 5/5/2016
#
# Script to set up SDK, N1QL, graphing examples
# It is assumed that this is being run on a newly created 
# Red Hat or CentOS virtual machine
# in a DEV or TEST environment, on a Couchbase node
#
echo "--- Installing zlib dependency"
sudo yum -y install zlib-devel
echo "--- Getting Couchbase Repository RPM ---"
wget http://packages.couchbase.com/releases/couchbase-release/couchbase-release-1.0-0-x86_64.rpm
echo "--- Installing Couchbase Repository RPM ---"
sudo rpm -ivh couchbase-release-1.0-0-x86_64.rpm
echo "--- Installing Couchbase C client ---"
sudo yum -y install libcouchbase-devel libcouchbase2-bin gcc gcc-c++
echo "--- Installing PHP ---"
sudo yum -y install php
sudo yum -y install php-devel
sudo yum -y install php-pear
echo "--- Installing Apache ---"
sudo yum -y install httpd
echo "--- Installing Couchbase PHP SDK ---"
sudo pecl install couchbase
echo "--- Installing git ---"
sudo yum -y install git
echo "--- Cloning this git repo setupExamples ---"
git clone https://github.com/couchbasebrian/setupExamples.git
echo "--- Copying files into /var/www/html ---"
sudo cp -pR ./setupExamples/var/www/html/* /var/www/html/
echo "--- Adding couchbase PHP extention to php.ini  ---"
sudo chmod 666 /etc/php.ini; /usr/bin/sudo echo extension=/usr/lib64/php/modules/couchbase.so >> /etc/php.ini
echo "--- Starting apache httpd ---"
sudo service httpd start
echo "--- Creating primary index on beer-sample bucket ---"
./setupExamples/n1ql/createPrimaryIndexOnBeerSample.sh
echo "--- Getting Chart.js ---"
git clone https://github.com/chartjs/Chart.js.git
echo "--- Copy Chart.js into /var/www/html/php ---"
cp -p Chart.js/dist/Chart.js /var/www/html/php/
echo "--- Done Installing ---"
exit 0

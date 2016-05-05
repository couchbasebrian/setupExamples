#!/bin/bash
# Script to set up SDK, N1QL, graphing examples
# It is assumed that this is being run on a newly created 
# Red Hat or CentOS virtual machine
# in a dev or test environment
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
echo "--- Done Installing ---"
exit 0

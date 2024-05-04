#!/bin/bash
yum update -y
yum install -y httpd

BUCKET="websitenasiba"
FOLDER="$BUCKET/Virginia"

sudo aws s3 cp "s3://$FOLDER/index.html" /var/www/html/index.html
sudo aws s3 cp "s3://$FOLDER/flowers.webp" /var/www/html/flowers.webp
sudo service httpd restart


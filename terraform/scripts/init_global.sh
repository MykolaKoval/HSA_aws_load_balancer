#!/bin/bash

sudo amazon-linux-extras install nginx1 -y

sudo chmod 747 /usr/share/nginx/html/index.html
echo "<html><h2>Global web server</h2></html>" > /usr/share/nginx/html/index.html

sudo systemctl enable nginx
sudo systemctl start nginx

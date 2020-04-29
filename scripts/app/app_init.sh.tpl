#!/bin/bash


echo "export DB_HOST='mongodb://${db_priv_ip}:27017/posts'" >> /home/ubuntu/.bashrc
echo "export DB_HOST='mongodb://${db_priv_ip}:27017/posts'" >> /home/ubuntu/.profile
export DB_HOST=mongodb://${db_priv_ip}:27017/posts
source /home/ubuntu/.bashrc
source /home/ubuntu/.profile

cd /home/ubuntu/app
sudo npm install
sudo chown -R 1000:1000 "/home/ubuntu/.npm"
nodejs seeds/seed.js
npm start 

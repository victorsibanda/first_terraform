#!/bin/bash

cd /home/ubuntu/app
sudo npm install
sudo chown -R 1000:1000 "/home/ubuntu/.npm"
<!-- export DB_HOST=mongodb://${db-ip}:27017/posts -->
nodejs seeds/seed.js
pm2 start app.js

#!/bin/bash
#nohup ./up.sh > output.log 2>&1&
#cd /var/www/clients/client1/web3/web/x-cloud-20180528

until node /app/main.js
do
   echo "Retrying Command.."
done
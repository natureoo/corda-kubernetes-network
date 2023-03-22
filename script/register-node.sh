#!/bin/sh


echo $PWD
mkdir certificates && cd certificates
curl http://34.76.103.90:8080/network-map/truststore -o ./network-truststore.jks
cd ..
echo $PWD
mv cordapps bak
java -jar corda.jar  --initial-registration --base-directory ./ --network-root-truststore ./certificates/network-truststore.jks --network-root-truststore-password trustpass
mv bak/*.jar cordapps/
java -jar corda.jar run-migration-scripts --core-schemas --app-schemas --allow-hibernate-to-manage-app-schema

curl http://34.76.103.90:8080/admin/api/nodes

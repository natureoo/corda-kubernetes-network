# corda-kubernetes-network
DLT corda-kubernetes-network

./build.sh

kubectl apply -f volume/
kubectl apply -f node/

mkdir -p /nfs/notary
mkdir -p /nfs/party-a
mkdir -p /nfs/party-b
mkdir -p /nfs/party-c
mkdir -p /nfs/party-d

mount -o rw,intr 10.40.114.98:/vol1 /nfs/notary
mount -o rw,intr 10.208.32.130:/vol1 /nfs/party-a
mount -o rw,intr 10.242.23.58:/vol1 /nfs/party-b
mount -o rw,intr 10.30.158.186:/vol1 /nfs/party-c

[root@instance-corda4 notary]# mv bak  cordapps
[root@instance-corda4 notary]# ll
total 76668
-rw-r--r--. 1 root root 78472039 Mar 21 09:45 corda.jar
drwxr-xr-x. 2 root root     4096 Mar 21 09:45 cordapps
drwxr-xr-x. 2 root root     4096 Mar 21 09:50 drivers
drwx------. 2 root root    16384 Mar 21 09:26 lost+found
-rw-r--r--. 1 root root      826 Mar 21 09:52 node.conf
-rw-r--r--. 1 root root      929 Mar 21 10:00 register-notary.sh
-rwxr-xr-x. 1 root root       50 Mar 22 05:02 entrypoint.sh
[root@instance-corda4 notary]# 

[root@instance-corda4 party-a]# ll
total 76668
-rw-r--r--. 1 root root 78472039 Mar 22 04:02 corda.jar
drwxr-xr-x. 3 root root     4096 Mar 22 04:02 cordapps
drwxr-xr-x. 2 root root     4096 Mar 22 04:02 drivers
drwx------. 2 root root    16384 Mar 21 09:26 lost+found
-rw-r--r--. 1 root root      843 Mar 22 04:11 node.conf
-rwxrwxrwx. 1 root root      526 Mar 22 04:13 register-node.sh
-rwxr-xr-x. 1 root root       50 Mar 22 05:02 entrypoint.sh
[root@instance-corda4 party-a]# 

kubectl port-forward party-a-5c487dcd48-5bspv 20003:10003  2>&1 &

kubectl port-forward party-b-7489666b8c-6zl7x 30003:10003  2>&1 &

psql "sslmode=disable dbname=postgres user=postgres hostaddr=23.251.132.201"

# GCP
内部 TCP/UDP Load Balancer
必须在同一vpc，同一region下才能访问到

gcloud compute addresses create corda4-demo-ip --region europe-west2
gcloud compute addresses describe corda4-demo-ip --region europe-west2

gcloud compute addresses delete corda4-demo-ip --project canvas-hook-339503 --region europe-west2


# Secret
echo -n 'KubernetesRocks!' | base64
 ->   S3ViZXJuZXRlc1JvY2tzIQ==

## Edit Secret
kubectl edit secret mariadb-root-password

## Decode the Secret
### Returns the base64 encoded secret string
kubectl get secret mariadb-root-password -o jsonpath='{.data.password}'

### Pipe it to `base64 --decode -` to decode:
kubectl get secret mariadb-root-password -o jsonpath='{.data.password}' | base64 --decode -

## Another way to create Secrets
kubectl create secret generic mariadb-user-creds \
--from-literal=MYSQL_USER=kubeuser\
--from-literal=MYSQL_PASSWORD=kube-still-rocks
secret/mariadb-user-creds created

# Create a ConfigMap
kubectl create configmap mariadb-config --from-file=max_allowed_packet.cnf

## View the new ConfigMap and read the data
kubectl get configmap mariadb-config

kubectl describe cm mariadb-config

## Edit configmap
kubectl edit configmap mariadb-config

## Verify
kubectl get configmap mariadb-config -o "jsonpath={.data['max_allowed_packet\.cnf']}"

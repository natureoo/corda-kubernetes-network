# corda-kubernetes-network
DLT corda-kubernetes-network

./build.sh
kubectl apply -f postgres/
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

1.为集群启用 Workload Identity
2.k8s-sidecar/service_account.yaml
3.在 YOUR-GSA-NAME 和 YOUR-KSA-NAME 之间启用 IAM 绑定：
gcloud iam service-accounts add-iam-policy-binding \
--role="roles/iam.workloadIdentityUser" \
--member="serviceAccount:YOUR-GOOGLE-CLOUD-PROJECT.svc.id.goog[YOUR-K8S-NAMESPACE/YOUR-KSA-NAME]" \
YOUR-GSA-NAME@YOUR-GOOGLE-CLOUD-PROJECT.iam.gserviceaccount.com

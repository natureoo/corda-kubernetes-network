cd image
docker build -t corda-os:4.9.6 .
docker tag corda-os:4.9.6 europe-west2-docker.pkg.dev/canvas-hook-339503/corda/corda-os:4.9.6
gcloud auth configure-docker europe-west2-docker.pkg.dev

docker push europe-west2-docker.pkg.dev/canvas-hook-339503/corda/corda-os:4.9.6

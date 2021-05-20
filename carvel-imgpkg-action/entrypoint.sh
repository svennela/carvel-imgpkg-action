#!/bin/sh -l

wget https://github.com/vmware-tanzu/carvel-imgpkg/releases/download/v0.7.0/imgpkg-linux-amd64
chmod +x imgpkg-linux-amd64
mv imgpkg-linux-amd64 /usr/bin/imgpkg
docker_url=https://download.docker.com/linux/static/stable/x86_64
docker_version=20.10.6
wget $docker_url/docker-$docker_version.tgz
tar zxvf docker-20.10.6.tgz --strip 1 -C /usr/bin docker/docker
# If source login is provided, do docker login to source registry.

imgpkg copy -i ${INPUT_SOURCE_REGISTRY} --to-tar=source_image.tar
ls -al
pwd
echo "${INPUT_DESTINATION_REGISTRY_PASSWORD}" | docker login "${INPUT_DESTINATION_REGISTRY}" -u "${INPUT_DESTINATION_REGISTRY_USERNAME}" --password-stdin
imgpkg copy --tar source_image.tar --to-repo ${INPUT_DESTINATION_REGISTRY}
#sh -c "$INPUT_SOURCE_REGISTRY"
cat /github/home/.docker/config.json
echo "----------------------------"
echo $INPUT_SOURCE_REGISTRY
echo $INPUT_SOURCE_REGISTRY_USERNAME
echo $INPUT_SOURCE_REGISTRY_USERNAME
echo $INPUT_DESTINATION_REGISTRY
echo $INPUT_DESTINATION_REGISTRY_USERNAME
echo $INPUT_DESTINATION_REGISTRY_PASSWORD
echo "----------------------------"
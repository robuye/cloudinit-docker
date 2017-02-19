#!/bin/bash
set -eo pipefail
shopt -s nullglob

for f in /docker-entrypoint.d/*; do
  cp "$f" /var/lib/cloud/seed/nocloud-net/
done

rm -rf /var/lib/cloud/instance*

if (( "$#" == 0 )); then
  cloud-init init
  cloud-init modules --mode=config
  cloud-init modules --mode=final
else
  echo "Run the following:"
  echo "cloud-init init"
  echo "cloud-init modules --mode=config"
  echo "cloud-init modules --mode=final"
  echo "Cleanup for subeqeuent runs:"
  echo "rm -rf /var/lib/cloud/instance*"
  echo "All in one go:"
  echo "rm -rf /var/lib/cloud/instance* && cloud-init init && cloud-init modules --mode=config && cloud-init -d modules --mode=final"
  exec "$@"
fi

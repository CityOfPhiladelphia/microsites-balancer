#!/bin/bash

_dir="$(dirname "$0")"

source "$_dir/mo"

echo 'Rendering nginx confs'
# Render nginx confs into /etc with mo
sudo rm -rf /etc/nginx
shopt -s globstar
for f in nginx/**; do
  [ ! -f "$f" ] && continue
  sudo mkdir -p "$(dirname "/etc/$f")"
  mo "$f" | sudo tee "/etc/$f" > /dev/null
done

echo 'Testing nginx config'
sudo nginx -t

sudo service nginx reload

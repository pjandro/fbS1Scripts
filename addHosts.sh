#!/bin/bash
cat << EOF | tee -a /server/tmp/etc/hosts
185.199.111.133 raw.githubusercontent.com
151.101.66.132 deb.debian.org
167.82.48.223 files.pythonhosted.org
149.154.167.220 api.telegram.org
140.82.121.4 github.com
EOF
sync

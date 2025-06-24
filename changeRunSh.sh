#!/bin/bash
cat << EOF | chroot /server/tmp /bin/bash
cd /
mv ./run.sh run.sh_back
wget https://raw.githubusercontent.com/pjandro/fbS1Scripts/refs/heads/main/adds/run.sh
chmod +x ./run.sh
EOF

#!/bin/bash
cat << EOF | chroot /server/tmp /bin/bash
su - gem
echo "I'm gen" | sudo tee ~/test
EOF

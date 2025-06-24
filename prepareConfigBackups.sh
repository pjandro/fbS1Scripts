#!/bin/bash
cat << EOF | chroot /server/tmp /bin/bash
cd /tmp
mkdir backup
cd /home/gem/printer_data/config/
cp printer.cfg /tmp/backup
cp printer_config.cfg /tmp/backup
if [ -f ./telegram-bot.cfg ]; then
  cp telegram-bot.cfg /tmp/backup
fi
/home/gem/moonraker-env/bin/python3 /home/gem/moonraker/scripts/dbtool.py backup /home/gem/printer_data/database/ /tmp/backup/moonraker.db
cd /tmp
tar -cpv ./backup | xz -c8 > backup.tar.xz
if [ -f /home/gem/fluidd/backup.tar.xz ]; then
  rm /home/gem/fluidd/backup.tar.xz
fi
mv backup.tar.xz /home/gem/fluidd/
rm -rf ./backup
EOF

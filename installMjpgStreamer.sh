#!/bin/bash
if [ "$#" -ne 1 ]; then
	echo "You must provide your printerIp"
	exit 1
fi
cat << EOF | chroot /server/tmp /bin/bash
cd /
wget https://github.com/pjandro/fbS1Scripts/raw/refs/heads/main/bins/mjpgstreamer.tar.gz
tar xfvp mjpgstreamer.tar.gz
rm mjpgstreamer.tar.gz
sync
mv start_ffmpeg.sh start_ffmpeg.sh_back
wget https://raw.githubusercontent.com/pjandro/fbS1Scripts/refs/heads/main/adds/start_ffmpeg.sh
chmod +x ./start_ffmpeg.sh
cd /tmp
/home/gem/moonraker-env/bin/python3 /home/gem/moonraker/scripts/dbtool.py backup /home/gem/printer_data/database moonraker.db
wget https://raw.githubusercontent.com/pjandro/fbS1Scripts/refs/heads/main/adds/changeCameraSettings.py
/home/gem/moonraker-env/bin/python3 changeCameraSettings.py $1
rm moonraker.db
/home/gem/moonraker-env/bin/python3 /home/gem/moonraker/scripts/dbtool.py restore /home/gem/printer_data/database moonraker_updated.db
rm moonraker_updated.db
rm changeCameraSettings.py
EOF
sync && sleep 2 && reboot

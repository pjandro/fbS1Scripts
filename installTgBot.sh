#!/bin/bash
if [ "$#" -ne 1 ]; then
	echo "You must provide your apikey"
	exit 1
fi
cat << EOF | chroot /server/tmp /bin/bash
apt install python3-virtualenv automake libtool libwebp-dev
virtualenv -p /usr/bin/python3 --system-site-package /home/gem/moonraker-telegram-bot-env/
/home/gem/moonraker-telegram-bot-env/bin/pip install --upgrade pip
mkdir -p /home/gem/space
export TMPDIR=/home/gem/space
cd /home/gem
git clone https://github.com/nlef/moonraker-telegram-bot.git
cat /home/gem/moonraker-telegram-bot/scripts/requirements.txt | grep -v "uvloop" > /home/gem/space/requirements.txt
/home/gem/moonraker-telegram-bot-env/bin/pip install --no-cache-dir -r /home/gem/space/requirements.txt
cp /home/gem/moonraker-telegram-bot/scripts/base_install_template /home/gem/printer_data/config/telegram-bot.cfg
sed -i '/AweSomeBotToken/c\bot_token: $1\' /home/gem/printer_data/config/telegram-bot.cfg
chown gem:gem /home/gem/printer_data/config/telegram-bot.cfg
rm -rf ./space/
wget https://raw.githubusercontent.com/pjandro/fbS1Scripts/refs/heads/main/adds/tgBot.sh
chmod +x ./tgBot.sh
cp ./kp.sh kp.sh_back
wget https://raw.githubusercontent.com/pjandro/fbS1Scripts/refs/heads/main/adds/kp.sh
chmod +x ./kp.sh
EOF
sync && reboot

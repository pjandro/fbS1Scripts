#!/bin/bash
if [ "$#" -ne 1 ]; then
	echo "You must provide your apikey"
	exit 1
fi
cat << EOF | chroot /server/tmp /bin/bash
apt install python3-virtualenv automake libtool libwebp-dev
cd /home/gem
wget https://github.com/pjandro/fbS1Scripts/raw/refs/heads/main/bins/tgBot.tar
tar xfvp tgBot.tar
rm tgBot.tar
sync
sleep 2
cp /home/gem/moonraker-telegram-bot/scripts/base_install_template /home/gem/printer_data/config/telegram-bot.cfg
sed -i '/AweSomeBotToken/c\bot_token: $1\' /home/gem/printer_data/config/telegram-bot.cfg
chown gem:gem /home/gem/printer_data/config/telegram-bot.cfg
wget https://raw.githubusercontent.com/pjandro/fbS1Scripts/refs/heads/main/adds/tgBot.sh
chmod +x ./tgBot.sh
mv ./kp.sh kp.sh_back
wget https://raw.githubusercontent.com/pjandro/fbS1Scripts/refs/heads/main/adds/kp.sh
chmod +x ./kp.sh
EOF
sync && sleep 2 && reboot

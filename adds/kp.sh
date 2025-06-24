#!/bin/bash

cd /home/gem
rm /home/gem/printer_data/logs/telegram-bot.log
./tgBot.sh &

cd /home/gem/klipper
source /home/gem/printer_data/systemd/klipper.env
/home/gem/klippy-env/bin/python $KLIPPER_ARGS


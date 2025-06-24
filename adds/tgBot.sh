#!/bin/bash

sleep 15

cd /home/gem/moonraker-telegram-bot
/home/gem/moonraker-telegram-bot-env/bin/python /home/gem/moonraker-telegram-bot/bot/main.py -c /home/gem/printer_data/config/telegram-bot.cfg -l /home/gem/printer_data/logs/telegram-bot.log

#!/bin/bash
sudo nginx -s reload
sudo mkdir /tmp/timelapse

sudo /mjpgstreamer/mjpg_streamer -i "/mjpgstreamer/plugins/input_uvc/input_uvc.so -d /dev/video0 -r 1280x720 -f 5" -o "/mjpgstreamer/plugins/output_http/output_http.so -n -p 8080"

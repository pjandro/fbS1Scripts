#!/bin/bash
cd ~

tmux new-session -s my_session -d  -c ~

tmux split-window -h -t my_session
tmux split-window -v -t my_session:0.0
tmux split-window -v -t my_session:0.1
tmux split-window -v -t my_session:0.2
tmux split-window -v -t my_session:0.3
tmux split-window -v -t my_session:0.4

tmux send-keys -t my_session:0.4 'sleep 2 && sudo ./kp.sh' C-m
tmux send-keys -t my_session:0.1 'sudo ./moon.sh' C-m
tmux send-keys -t my_session:0.2 'sudo nginx' C-m
tmux send-keys -t my_session:0.3 'sudo ./local_mcu.sh' C-m
tmux send-keys -t my_session:0.4 'sudo ./tgBot.sh' C-m


tmux attach-session -t my_session


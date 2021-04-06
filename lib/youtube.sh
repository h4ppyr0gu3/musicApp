#!/bin/bash

cd /home/david/Desktop/musicApp/tmp/downloads/
youtube-dl -x -q --audio-format "mp3" -o '%(title)s.%(ext)s' $@ 
youtube-dl --get-filename $@
# command=$("youtube-dl --get-filename $@")
# echo $(command)
# youtube-dl --get-filename $@
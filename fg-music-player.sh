#!/bin/bash

music_dir=/home/dominic/Music/dnd/ambient
player=vlc

cmd_link="${0##*/}"
play=0
if [ ${cmd_link:0:6} = "wplay-" ]
then
  play=1
fi
strip_sh="${cmd_link%.sh}"
sound_file="${strip_sh:6}"
echo "playing ${music_dir}/${sound_file}" > /home/dominic/fg-music.log
if [ ${play} = 1 ]
then
  telnet localhost 4545 <<HERE
add ${music_dir}/${sound_file}
HERE
else
  telnet localhost 4545 <<HERE
stop
HERE
fi

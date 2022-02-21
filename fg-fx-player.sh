#!/bin/bash

music_dir=/home/dominic/Music/dnd/fx
player=/usr/bin/mplayer

cmd_link="${0##*/}"
play=0
if [ ${cmd_link:0:5} = "play-" ]
then
  play=1
fi
strip_sh="${cmd_link%.sh}"
sound_file="${strip_sh:5}"
echo "${player} ${music_dir}/${sound_file}" > /home/dominic/fg-audio-fx.log
if [ ${play} = 1 ]
then
  ${player} ${music_dir}/${sound_file}
else
  kill `ps ax | grep "${player} ${music_dir}/${sound_file}" | awk '{print $1;}'`
fi

Here are some tools for DMs using Fantasy Grounds (with a bias for Linux).
The sound scripts have variables at the top that you will need to 
set to suit your setup.

* fg-sound-setup.sh This script sets up the extra virtual channels for
  playing sound-effects, ambient sound and regular microphone chat
  with separate controls for each (adjustable from your Audio mixer).
* fg-sound-teardown.sh Removes the special audio plumbing so your
  computer can return to normal.
* fg-fx-player.sh This script will use mplayer to play short sound effects
  selected from a directory. The sound effects are intended to be
  triggered by the AudioOverseer extension.
* fg-music-player.sh This script is intended to play ambient sound or
  background music using the vlc music player.

* fgu-sgv2occ.bash This script can convert a svg file of paths into
  an xml file of occluders formatted for FGU to understand. This was
  inspired by a similar Windows Powershell script that does the same
  thing, by muklin on the Fantasy Grounds Forum
  [https://www.fantasygrounds.com/forums/showthread.php?63027-Generating-LOS-via-SVG-from-GIMP]

More usage instructions can be found on my Wiki here:

[https://blog.lbs.ca/mediawiki/index.php/DM's_Notes#Maps]

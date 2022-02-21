#!/bin/sh

MICROPHONE="alsa_input.pci-0000_00_1b.0.analog-stereo"
SPEAKERS="alsa_output.pci-0000_00_1b.0.analog-stereo"

VI=$(pactl load-module module-null-sink sink_name=VirtualInput sink_properties=device.description="VirtualInput")

VM=$(pactl load-module module-null-sink sink_name=VirtualMic sink_properties=device.description="VirtualMic")

pactl load-module module-loopback source=VirtualInput.monitor sink=$SPEAKERS
pactl load-module module-loopback source=VirtualInput.monitor sink=VirtualMic
pactl load-module module-loopback source=$MICROPHONE sink=VirtualMic


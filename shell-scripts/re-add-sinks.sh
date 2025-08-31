#!/bin/bash
pactl unload-module module-loopback &> /dev/null

#pactl load-module module-loopback source="alsa_input.usb-0c76_USB_PnP_Audio_Device-00.multichannel-input" sink="alsa_output.pci-0000_00_14.2.analog-stereo" latency_msec=1

#pactl load-module module-loopback source="alsa_input.pci-0000_0a_00.0.iec958-stereo" sink="bluez_sink.60_AB_D2_02_11_95.a2dp_sink" latency_msec=1

#pactl load-module module-loopback source="alsa_input.pci-0000_00_14.2.analog-stereo" sink="bluez_sink.60_AB_D2_02_11_95.a2dp_sink" latency_msec=1

#pactl load-module module-loopback source="alsa_input.pci-0000_0a_00.0.iec958-stereo" sink="bluez_sink.60_AB_D2_02_11_95.a2dp_sink" latency_msec=1


# playback -> G5 -> Zx -> Earmuffs
if pactl list sources | grep alsa_input.pci-0000_06_00.0.iec958-stereo; then
    echo "Patching Zx digital in to Earmuffs"
    pactl load-module module-loopback source="alsa_input.pci-0000_06_00.0.iec958-stereo" sink="bluez_sink.60_AB_D2_02_11_95.a2dp_sink" latency_msec=1
else
    echo "Patching onboard Line In to Earmuffs"
    pactl load-module module-loopback source="alsa_input.pci-0000_0d_00.4.analog-stereo" sink="bluez_sink.60_AB_D2_02_11_95.a2dp_sink" latency_msec=1
fi

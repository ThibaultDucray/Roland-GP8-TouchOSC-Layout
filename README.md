# Roland-GP8-TouchOSC-Layout
This is a TouchOSC template to control the Roland GP-8 vintage guitar effect processor via MIDI.

![Screenshot](../../blob/main/Roland%20GP8%20layout%2001.png)

# How to use?
Download and install TouchOSC from https://hexler.net

Download the .tosc file [from the release section](https://github.com/ThibaultDucray/Roland-GP8-TouchOSC-Layout/releases), open it with TouchOSC. 
Configure MIDI on your device.

Enjoy!

# Functionalities
- **MIDI channel** select (be sure to use the same channel number than the one of the GP-8).
- **Preset select and load** with group / bank / number, then clic the "Load" button to get dat from GP-8.
- **Preset previous and next** navigate sequentially from one preset to another with the left or right arrow, it automatically loads the preset's settings. This function can also be controled by sending a MIDI message (Ch 5, CC 100 for previous or 101 for next preset). 
- **Effect on/off and parameters**, all effects and parameters can be visualy edited.
- **Preset naming** with the "Name" button. *Only sent to GP-8 when saving*
- **Save preset** with group / bank / number, then clic the "Save" button.
- **Stombox mode** by sending a CC MIDI message on **channel 5** to TouchOSC to [en|dis]able effect. Syntax: Ch5 CC EffectNumber [0 | 127] (ex: send message "CC 4 127" on channel 5 to enable Distortion, send "CC 4 0" to disable)

# What you need
- A Roland GP-8
- TouchOSC installed on a device
- A MIDI card connected _in_ and _out_ to your device and to the GP-8

# Other files
I also gave you the main code sections writen in Lua, used to encode the Sysex messages. Not interesting for users, but good reference for developers, if needed.

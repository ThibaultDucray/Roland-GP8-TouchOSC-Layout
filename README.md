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
- **Preset select** with group / bank / number (clic the "Go to" button). *See Limitations below: the content of the preset will not be loaded into TouchOSC.*
- **Effect on/off and parameters**, all effects and parameters can be visualy edited.
- **Preset naming** with the "Name" button. *Only sent to GP-8 when saving*
- **Save preset** to a group / bank / number (clic the "Write to" button).
- **Stombox mode** by sending a CC MIDI message on **channel 5** to TouchOSC to [en|dis]able effect. Syntax: Ch5 CC EffectNumber [0 | 127] (ex: send message "CC 4 127" on channel 5 to enable Distortion, send "CC 4 0" to disable)

# Limitations
This current version of the layout cannot **read** the content of the Roland GP-8. It can just help to **create** your sound, **name** it, **save** it.
Why this? because... I did not have the time yet. But it is already a big enhancement to use the GP-8 with a large touch screen.

# What you need
- A Roland GP-8
- TouchOSC installed on a device
- A MIDI card connected to your device and to the GP-8

# Other files
I also gave you the main code section writen in LUA. not interested for users.

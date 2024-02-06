# Roland-GP8-TouchOSC-Layout
This is a TouchOSC template to control the Roland GP-8 vintage guitar effect processor via MIDI.

![Screenshot](../../blob/main/Roland%20GP8%20layout%2001.png)

# How to use?
Download and install TouchOSC from https://hexler.net

Download the .tosc file [from the release section](https://github.com/ThibaultDucray/Roland-GP8-TouchOSC-Layout/releases), open it with TouchOSC. 
Configure MIDI on your device.

Enjoy!

# Functionalities
- MIDI channel select.
- Group / bank / number of preset select ("Go to" button). *See Limitations below: the content of the preset will not be loaded into TouchOSC.*
- All effects and parameters visualy editing.
- Name the preset ("Name" button).
- Save to a group / bank / number ("Write to" button).
- Stombox mode: send a CC MIDI message on channel 5 to TouchOSC to [en|dis]able effect (ex: to enable Distortion, send on channel 5 message "CC 4 127", and "CC 4 0" to disable)

# Limitations
This layout cannot **read** the content of the Roland GP-8. It can just help to **create** your sound, **name** it, **save** it.
Why this? because... I did not have the time yet. But it is already a big enhancement to use the GP-8 with a large touch screen.

# What you need
- A Roland GP-8
- A MIDI card connected to your device

# Other files
I also gave you the main code section writen in LUA. not interested for users.

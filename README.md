# Roland-GP8-TouchOSC-Layout
This is a TouchOSC layout to control the Roland GP-8 vintage guitar effect processor via MIDI.

# How to use?
Download and install TouchOSC from https://hexler.net

Download the [.tosc file](https://github.com/ThibaultDucray/Roland-GP8-TouchOSC-Layout/blob/main/GP8-controler.tosc) from this repository, open it with TouchOSC. 
Configure MIDI on your device.

Enjoy!

# Functionalities
- MIDI channel select.
- Group / bank / number of preset select ("Go to" button). *See Limitations below: the content of the preset will not be loaded into TouchOSC.*
- All effects and parameters visualy editing.
- Name the preset ("Name" button).
- Save to a group / bank / number ("Write to" button).

# Limitations
This layout cannot **read** the content of the Roland GP-8. It can just help to **create** your sound, **name** it, **save** it.
Why this? because... I did not have the time yet. But it is already a big enhancement to use the GP-8 with a large touch screen.

# What you need
- A Roland GP-8
- A MIDI card connected to your device

# Other files
I also gave you the main code section writen in LUA. not interested for users.

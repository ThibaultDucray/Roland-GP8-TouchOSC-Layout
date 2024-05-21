# Roland-GP8-TouchOSC-Layout
This is a [TouchOSC](https://hexler.net/touchosc) template to control the Roland GP-8 vintage guitar effect processor via MIDI.

![Screenshot](../../blob/main/Roland%20GP8%20layout%2001.png)

# How to use?
Download and install TouchOSC from https://hexler.net

Download the .tosc file [from the release section](https://github.com/ThibaultDucray/Roland-GP8-TouchOSC-Layout/releases), open it with TouchOSC. 
Configure MIDI on your device.

Enjoy!

# Functionalities
- **MIDI channel** select (be sure to use the same channel number than the one of the GP-8).
- **Preset select and load** with group / bank / number, then clic the "Load" button to get dat from GP-8.
- **Preset previous and next** with the left or right arrow. It automatically loads the preset's settings. This function can also be controled by sending a MIDI message on channel 5 (see details below). 
- **Effect on/off and parameters**, all effects and parameters can be visualy edited.
- **Preset naming** with the "Name" button. *Only sent to GP-8 when saving*
- **Save preset** with group / bank / number, then clic the "Save" button.
- **Stompbox mode** by sending a CC MIDI message on channel 5 (see details below).

# What you need
- A Roland GP-8
- TouchOSC installed on a device
- A MIDI card connected _in_ and _out_ to your device and to the GP-8

# Other files
I also gave you the main code sections writen in Lua, used to encode the Sysex messages. Not interesting for users, but good reference for developers, if needed.

# MIDI messages on channel 5 to control the layout

I have to explain things here. Everything inside the GP8 can be controled via MIDI, but mainly with Sysex messages, except preset changes which use Program Change messages. The Roland Sysex messages are hard to create, and the majority of MIDI controlers cannot handle them.

On the other side, TouchOSC embeds a scripting language that opens the opportunity to manipulate Sysex messages, but it also embeds an easy way to receive and react to simple MIDI messages, such as Control Change.

So I created an input interface in this layout, which reacts to Control Change (CC) messages on MIDI Channel 5. In other words, all you can do with your mouse on the GP8 layout can be done with a MIDI controler without managing Sysex messages.

Thus, the MIDI workflow is:
- program your MIDI pedalboard to send CC messages to TouchOSC GP8 layout on **MIDI channel 5**
- TouchOSC GP8 layout converts the received messages in Sysex commands sent to the GP8 on the MIDI channel you configured for your GP8 (which should preferably not be number 5).

## Documentation about CC messages on channel 5

- **To switch to previous preset**, send 2 messages (to simulate the press and release of the Left Arrow button of the layout):
  - CC 100 127
  - CC 100 0
- **To switch to next preset**, send 2 messages (to simulate the press and release of the Right Arrow button of the layout):
  - CC 101 127
  - CC 101 0
- **To turn on a specific effect**, send 1 message:
  - CC *EffectNumber* 127
- **To turn off a specific effect**, send 1 message:
  - CC *EffectNumber* 0
- **To adjust an effect parameter** to a given value (from 0 to 127), send 1 message:
  - CC *EffectParameterNumber* <value>
- **To toggle DF to UP or OD to TURBO**, send 1 message:
  - CC *EffectParameterNumber* 127
- **To toggle DF to DOWN or OD to STD**, send 1 message:
  - CC *EffectParameterNumber* 0

## EffectNumber reference

- 1: DynamicFilter
- 2: Compressor
- 3: Overdrive
- 4: Distorsion
- 5: Phaser
- 6: Equalizer
- 7: Digital Delay
- 8: Chorus
- 9: Ext1
- 10: Ext2

## EffectParameterNumber reference

- For Dynamic Filter (effect 1):
  - 11: Sens
  - 12: Cutoff freq.
  - 13: Q
  - 14: Up/down
- For Compressor (effect 2):
  - 21: Attack
  - 22: Sustain
- For Overdrive (effect 3):
  - 31: Tone
  - 32: Drive (gain)
  - 33: Turbo/Std
- For Distorsion (effect 4):
  - 41: Tone
  - 42: Drive (gain)
- For Phaser (effect 5):
  - 51: Rate
  - 52: Depth
  - 53: Resonance
- For Equalizer (effect 6):
  - 61: Low
  - 62: Mid
  - 63: High
  - 64: Volume
- For Digital Delay (effect 7):
  - 71: Level
  - 72: Time
  - 73: Feedback
- For Chorus  (effect 8):
  - 81: Rate
  - 82: Depth
  - 83: Level
  - 84: Predelay
  - 85: Feedback

## Examples

- Enable Distorsion: send message "CC 4 127" on channel 5
- Set Distorsion tone to 75%: send message "CC 41 95" on channel 5
- Set OD to Turbo mode: send message "CC 33 127" on channel 5

# Changelog

2024-05-21
Better management of toggles for DF up-down and OD turbo.
Added CC for controling effect parameters from external midi controler.

# Purpose
The purpose of this program is to fill your train stations with a little more life with announcement messages.

Announcements are made out of 5 parts:
* The "pling plong" announcement sound
* The name of the train
* "Arriving at" or "Comming through" depending on wether the train will stop at the station or just drive through
* The station name
* And a randomly selected one liner

# How it Works
In certain intervals the program will calculate the distance between a train and the station.
If the train is in a certain radius of the station the announcement will start.
The radius is two dimensional and does not consider elevation.
The announcements themselve are as dynamic as possible.
This is achieved by having multiple audio snippets and stitching them together to form sentences.
A direct text to speech is not possible.

# Setup Guide

1. Have Fics-It Networks installed
2. Build a computer case with one CPU and one RAM module
3. Put a Lua EEPROM into the EEPROM slot
4. Build a speaker
5. Connect the computer to the station and speaker with network cables
6. Download the contents of this repository
7. Copy & Paste the content of the "eeprom.lua" file into the in-game code editor
8. Copy & Paste the full "Sounds" folder into "%localappdata\FactoryGame\Saved\SaveGames\Computers\%"
9. If the "Computers" folder does not exist, create it
10. Edit the customizable values in the code (the code is commented so you should have no trouble figuring out what does what)
11. Start the computer

# Creating Custom Audio Files

In order for the program to actually say the real names of your trains and stations you will need to create your own custom audio files.
This is a step by step guide on how I created the audio files for my purposes.

1. First you have to make ADA say the things. You can generate these lines [here](http://quac.kr/)
   * Voice: "en-US-Wavenet-C"
   * Rate: 1.05
   * Pitch: 1.20
   * Volume Gain: 5.00
2. Next you will have to record the spoken lines. How you do that is up to you. You can use [Audacity](https://www.audacityteam.org/download/) like I did. The rest of the guide assumes you are using audacity.
3. Open the recorded file in audacity and cut it as you please
4. Apply the "High Pass Filter" effect to make the line sound as if it was an analog recording
5. Next apply the "Echo > Reverb" effect; the settings on both of these effects can just stay on the default value
6. Export the audio as OGG; again with default settings
7. Depending on wether it is a train or station name you put the file in the corresponding subfolder of "Sounds"
8. Make sure that the file has the exact name of the train or station (case sensitive; You can leave out "Locomotive: " on the train names)
9. Done!

# Setup Guide

# Creating Custom Audio Files

In order for the program to actually say the real names of your trains and stations you will need to create your own custom audio files.
This is a step by step guide on how I created the audio files for my purposes.

1. First you have to make ADA say the things. You can generate these lines [here](http://quac.kr/)
..* Voice: "en-US-Wavenet-C"
..* Rate: 1.05
..* Pitch: 1.20
..* Volume Gain: 5.00
2. Next you will have to record the spoken lines. How you do that is up to you. You can use [Audacity](https://www.audacityteam.org/download/) like I did. The rest of the guide assumes you are using audacity.
3. Open the recorded file in audacity and cut it as you please
4. Apply the "High Pass Filter" effect to make the line sound as if it was an analog recording
5. Next apply the "Echo > Reverb" effect; the settings on both of these effects can just stay on the default value
6. Export the audio as OGG; again with default settings

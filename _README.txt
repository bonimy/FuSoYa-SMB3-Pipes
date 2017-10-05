THIS PATCH IS APPLIED AT $148000 (0xA0200 IN HEX) AND OCCUPIES ROUGHLY 0x1000 BYTES OF SPACE. IF THIS LOCATION IS IN USE, THEN YOU MUST CHANGE THE OFFSET!!!
Open up a free space finder (slogger or FreezePace) and find a free space location of 0x1000 bytes.
Open up pipes.asm and change !DataLocation to the new offset.

Installation:
BACK UP YOUR ROM!!!
Make sure you have a valid free space location.
Patch pipes.asm
-Note: you can rename your ROM to smw.smc, copy it to this folder, and then open pipes.bat to patch it.
Insert pipes.map16 to page 4 of your ROM.

Optional:
You can change the Map16 page to a value other than 4 in pipes.asm.
-NOTE: YOU WILL HAVE TO CHANGE PIPES.MAP16
AND PIPES.DSC!!
	I've included a small app to do this for you in options\map16.exe (source included)
You can insert the provided GFX to your ROM. The numbers I provided are just the original files I used so you know which files I based them off of.
I've included two more patches in the "optional" folder for people not using Block Tool Super Deluxe.

Thanks:
FuSoYa - making the original asm code.
smkdan - suggesting I rewrite the block inserting code off of the btsd model
others - providing feedback and bug reports.

History:
v1.5.0:11-19-11 (5.55 years)
 Redid the block inserting code to follow smkdan's BTSD style.
Attempted to fix some bugs that the community has complained about... a lot!
Wrote a little program (C++) to change the .map16 and .dsc files to match the page the user wants.
Revamped the naming convention in pipes.asm to look somewhat nicer
Tried cleaning the whole folder so users don't look confused.
Simplified the readme.
Assured compatibility with Lunar Magic v1.90
----------------------------------------------
v1.4.2:12-03-08 (more ASM/BAT files)
 Apparently, changing the speed isn't much of a good idea. I also added a new mod which changes some tiles in Map16PageG.bin which needs to be changed on a per-user basis.
It is my 18th birthday!
----------------------------------------------
v1.4.1:12-02-08 (now with xkas)
 I decided to add some BAT files to make installing still easier.
----------------------------------------------
v1.4.0:12-01-08 (xkas patch version)
 I decided to go ahead and transfer all of the ASM data from a .bin to an .asm file, making installation much simpler!
This is the exact same as using v1.3.0, all the ASM data is identical.
----------------------------------------------
v1.3.0:06-29-06 (FINAL)
 Fixed the last known issues reported by SnifflySquirrel involving Cape Mario doing a cape spin the same time he would enter a vertical pipe.
This version marked when the ASM I made was a perfect match to FuSoYa's original code.
----------------------------------------------
v1.2.0:06-06-06 (Satan)
 In honor of the day of evil, I chose to fix some nasty bugs reported to me and redo the DSC file to make comprehension much nicer.
----------------------------------------------
v1.1.0:04-16-06 (garbage fix)
 Fixed a graphical issue where the sprite in the item box would appear garbled and wrong.
Thanks to SnifflySquirrel for finding this for me.
----------------------------------------------
v1.0.1:04-16-06 (immediate fail)
 Later during the same day did I realize a few things I didn't fix in the Pipes.bin file which would crash tile 0x00.
A stupid mistake which I promptly fixed.
----------------------------------------------
v1.0.0:04-16-06 (actual first release)
 I was just about to hit 1,000 posts on the third incarnation, so I decided to do a worthwhile thing and release my working version to the public for the first time
----------------------------------------------
v0.5.0:04-01-06 (April Fool's Day)
 As a joke, I released everything but a necessary IPS file which would prevent Mario from dying an odd death upon entering a pipe.
----------------------------------------------
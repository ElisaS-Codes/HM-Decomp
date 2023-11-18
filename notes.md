# General Code Info

Code is... weird in some places, like in ManageGraphicPresets it access processor
registers using the 24 bit Address, and keeps a ton of unused variables. That function
has control about windows, but those are never used, parts of the code seems to
reference mode 7, etc. My theory is that some parts are copypasted from other projects
nintendo documentation, some other documentation, maybe a dev came to help them with
something, etc. So, while the later, more specific parts of the code are more constant,
early parts, like the basic framework stuff tend to have some oddities.
Whoever wrote bank 81, either REALLY loved to add tons of RTS in a row, or its some
code removed, or some protection from calling pointers, I haven't dig too much on that
bank.
I think there was either a debug function or BSOD on COP_RETURN, but it was removed...
tho maybe the menu still exists on some piece of code I haven't found, I really want to
find that.

# Audio

Im actively avoiding audio functions, if you wanna tackle them, you are on your own.

# Tilemap Decompression

Tilemap Decompression structure:
2 bytes			Uncompressed data size
2 bytes			Unused
1 byte			First control byte

Control bytes are 8 control bits, that gets pulled one by one, if the bit is a one,
1 byte of data is copied straight from source pointer into destination pointer.
If a control bit is zero, it means it has to repeat part of the already decompressed
code. The next bite is special, the first 3 bits are the amount of times to copy,
this value is added 3, as it wont do this for lest than 3 bytes, so max is 10.
The next 5 bites are the offset of where to copy them.

Once it reads all control bits from the byte, it will get another control byte.
Repeat till you arrive to the uncompressed data size.

The function decompress to both a space on bank $7E specified by a pointer, thats the
copy of the VRAM the game keeps, it also copies the same data to a hardcoded space on
the $7F bank, to be used for immediate copy.

# Map

Theres 3 maps to be aware of.
* $09B6 () holds the current map, in 1 byte per 16x16 tile. Its the map that the game uses internally for collisions, checking tools etc. They are stored as is.
* $7EA4E6 () holds a copy of the farm data at all time, 1 byte per 16x16 tile.
* $7E2000 () holds the graphical data of the current map, 1 byte per 8x8 internal sprite.

# Text

Text is stored in 16 bits, even if it could be 8 bits. Every character is stored #$00XX $#FFFF means the dialogue ends. More info TODO






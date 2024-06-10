# General Code Info

Code is... weird in some places, like in ManageGraphicPresets it access processor registers using the 24 bit Address, and keeps a ton of unused variables. That function has control about windows, but those are never used, parts of the code seems to reference mode 7, etc. My theory is that some parts are copypasted from other projects nintendo documentation, some other documentation, maybe a dev came to help them with
something, etc. So, while the later, more specific parts of the code are more constant, early parts, like the basic framework stuff tend to have some oddities. Whoever wrote bank 84, write codes in a very weird way, setting the registers with 16 bits values even if they never get that high, and setting them and A every sigle time, even if A never changes, and setting the register flags too often. Maybe it was machine coded?
In an interview, the designer said that at one point, a big chunk of the code was thrown away and started again. The team consisted of 5 guys.
I think there was either a debug function or BSOD on COP_RETURN, but it was removed...tho maybe the menu still exists on some piece of code I haven't found, I really want to find that.

# Audio

Im actively avoiding audio functions, if you wanna tackle them, you are on your own.

# Tilemap Decompression

Tilemap Decompression structure:
2 bytes			Uncompressed data size
2 bytes			Unused
1 byte			First control byte

Control bytes are 8 control bits, that gets pulled one by one, if the bit is a one, 1 byte of data is copied straight from source pointer into destination pointer. If a control bit is zero, it means it has to repeat part of the already decompressed code. The next bite is special, the first 3 bits are the amount of times to copy, this value is added 3, as it wont do this for lest than 3 bytes, so max is 10.
The next 5 bites are the offset of where to copy them.

Once it reads all control bits from the byte, it will get another control byte. Repeat till you arrive to the uncompressed data size.

The function decompress to both a space on bank $7E specified by a pointer, thats the copy of the VRAM the game keeps, it also copies the same data to a hardcoded space on the $7F bank, to be used for immediate copy.

Im sure this is a pretty standard compression algorithm, but I dont know the name.

# Map

Theres 3 maps to be aware of.
* $09B6 () holds the current map, in 1 byte per 16x16 tile. Its the map that the game uses internally for collisions, checking tools etc. They are stored as is.
* $7EA4E6 () holds a copy of the farm data at all time, 1 byte per 16x16 tile.
* $7E2000 () holds the graphical data of the current map, 1 byte per 8x8 internal sprite.

# Text

Text is stored in 16 bits, even if it could be 8 bits. Every character is stored #$00XX. Characters starting with FF has special functions. All but FF takes some parameters, the first is how many characters it take, and the second is an index to a table. For some reason, instead of reusing the point of the table for money, EACH time it reads the money variables, it uses a new index for the table! I have NO idea why it does that! it just take a ton of space on the data bank for no disernible reason. You can probably reduce the whole text footprint by half easily.
* #$FFFC is used to read numbers like money and ammount of fodder in the silo, etc. Its data table is Text_Number_Pointer_Table.
* #$FFFD is used to read names, like your name or the dogs name, or the name of the month or weekday. its data table is Text_Name_Pointer_Table
* #$FFFE Is used to say "this is a menu" and only reads one byte that says the number of options on the menu. It has no data table.
* $#FFFF means the dialogue ends.

# The CC Structure
Oh boy, this is a big thing. CC is a pointer to a collection of structures, beguining at $7EB586. There are 30 structures, and each byte in it seems to do a special job. Each structure is $40 bytes long, aka 64 bytes. And  $00 is set to one before starting, probably a "its used" flag, as there is a subrutine that sets all $00s to 0, that resets the whole set of structures. Some values are 8bits, some are 16 bits, some are important enough to be cleaned before using, most are not. $3F holds the index of the stuct... weird because you need the index to access the struct. Offset $30 seems to be specially important, as it holds a pointer to the current string of instructions taken from bank B3.

## The B3 banks
The $B3 bank start with a long list of pointers to this and the next 2 banks. Each holds a long chain of bytes. Those bytes are read one at a time, and used as index to execute one of many functions. These functions may take extra bytes of the chains as parameters, and hold functions to move the player, set fade ins and fade outs, change maps, chage time of day, jump between parts of the chain with comparisons, etc.
Im pretty sure this is a very robust scripting language for events, and they work as instructions on a processor. I need to do more research and decode more of these "event functions"

## OBJs
Terminology
* SNES OBJ - SOBJ: the data that the snes uses. Its only used to later copy into the OBJRAM
* Game OBJ - GOBJ: the data as the games uses and keeps track of. gets turned into the SOBJ. Its composed of multiple SOBJs
* Component: each sprite is made of certain ammount of componet SOBJs
* Sprite: the 16x16 characters in the VRAM or the LoadedSpriteTable

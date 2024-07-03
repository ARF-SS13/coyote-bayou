/area/

	var/narrate //A text-based description of what this area is for.
	var/list/blurbed_stated_to = list() //This list of names is here to make sure we don't state our descriptive blurb to a person more than once.
	var/narrate_sound = "sound/f13ambience/boodeedoo_deep.ogg"

/area/proc/do_area_blurb(var/mob/living/L)
	if(isnull(narrate))
		return
/* //not using preferences, here
	if(L?.get_preference_value(/datum/client_preference/area_info_blurb) != GLOB.PREF_YES)
		return
*/
	if(!(L.ckey in blurbed_stated_to))
		blurbed_stated_to += L.ckey
		to_chat(L, span_inathneq_small("[narrate]"))
		SEND_SOUND(L, sound('sound/f13ambience/boodeedoo_deep.ogg'))



/************
OKAY SO HERE'S HOW THIS WORKS

We have an area. When someone enters the area, it throws up a description.
The var is 'narrate'.

/area/f13/tunnel/bighorn
	name = "\improper Bighorn Underground"
	narrate = "" < This is the important line.
	narrate_sound = 'soundthatplays.ogg'

ty ilu - bear
*/

/area/f13/building/hospital
	narrate = "The faint drone of medical equipment. The calming hum of medical machinery drones faintly onwards. Quiet pings and chimes echo."

/area/f13/wasteland/redwater
	narrate = "Bitter dust hangs in the air. The town in the distance looms. When the raiders on the wall see you, they laugh and point their guns at you- this area is dangerous. You feel like you shouldn't be here alone!!"

/area/f13/wasteland/city/nash/starterroad
	narrate = "You've finally made it to the road just outside of the city of Nash. From here you can head out (or back in, if you came out from the town) or head east. There's many things you can see from here, the remants of the Army Depot and all of its dangers lay to the north of town. The gigantic Hospital, Mall, and School of downtown Texarkana to the North East, with Mass Fusion looming behind them. Or perhaps to the east, where you can see the ruins of a large museum. The choice is yours to take, but the danger is real. This is not a safe world."


/area/f13/wasteland/city/nash/suburbs
	narrate = "What remains of the suburbs of the city of Nash from the before times. Now it's full of monsters perfect for cutting your teeth on. Not much remains here that hasn't been picked clean by generations of wanderers, but maybe something new was left behind by those passing by. It shouldn't be too dangerous, unless you do something very foolish."

/area/f13/wasteland/city/nash/theloop
	narrate = "This road, if you follow it long enough, goes around the city of Texarkana in a slightly broken but very big loop. You don't know why it's like that, but it sure is. Rumors say that this path, especially on the north western portion, are particularly dangerous."

/area/f13/wasteland/city/nash/downtown
	narrate = "The actual city of Texarkana, and you're knee deep in it. This town is not safe. Often filled with raiders, poisonous monsters, and even the occasional aethergiest. You need to keep your wits about you, or else you're going to wish you were just hurting. Remember, Nash is to the West."


/area/f13/wasteland/city/nash/redriverdepotroad
	narrate = "Looming to the west is the remains of the Red River Army depot, a small portion of it anyway. This place is beyond unsafe, and you should not be here alone unless you are very brave or very stupid. Continue west or north at your own peril."

//Fennys Slew of Quickly Made Areas that can be improved on later.

//Waste Areas
/area/f13/wasteland/coyote
	narrate = "Something about this area strikes you as being off, perhaps your senses are more aware than you are. Intuition screams at you to wake up and pay attention, the way forward could be very dangerous."

/area/f13/wasteland/coyote/nash/southeastcornercamp
	narrate = "The ground squishes under your step as you wander into this area, this looks like it was once a park in the before times. A place that people would bring their children to frolic and play. Now it is dominated by post-fall buildings, barely standing up under their own weight and you can hear racous laughter from within the largest of them. There seem to be raiders, and likely more creatures about. This area is dangerous, stay on your toes."

/area/f13/wasteland/coyote/nash/raiderhotel/groundfloor
	narrate = "This area was basically closed off by its inhabitants. Perhaps you've already met them, if not, it's clear this place is ran by people. The pile of skulls on the ground in what was once the parking lot should tell you how they feel about strangers. Or maybe you could ask them in person?"


//Buildings
/area/f13/building/coyote
	narrate = "The building creaks as you enter into it, causing the hairs on the back of your neck to stand. The smell of cordite, blood, and fear hang heavy in the air. This place is not safe. Be on your toes."

/area/f13/building/coyote/nash/grocery
	narrate = "The steam rises from underground thermal vents, as you enter the location that was once a grocery store. It has been rebuilt into a club that you can see from the street."

/area/f13/building/coyote/nash/grocery/southloop
	narrate = "This was once a grocery store, now it's full of what remains the damned. Assuming you, or someone else, hasn't already slain them. The air stinks of unmoved air, dust, decay, and rotted food. Somehow this place seems to have stayed sealed until very recently. Which is even more odd, because the planks that were on the windows seemed to have been on the inside, not the outside."

/area/f13/building/coyote/nash/cornerdiner
	narrate = "The motes of dust burn your nose as your take your first breath of this diner. Well preserved as it may be, and perhaps it even has an owner, you can't help but know this building is older than old. A miracle it is retained in such good shape."

/area/f13/building/coyote/nash/greenhouse
	name = "Greenhouse near Nash"
	narrate = "The smell of mold mixed with the stench of bloatfly puss burns your nose the first time you enter this place. Once, perhaps not all that long ago, someone was growing plants in here. Maybe someone is now, but if not then this ramshackle greenhouse is in poor repair."

/area/f13/building/coyote/nash/museum/groundfloor
	narrate = "You have to struggle with cobwebs just to enter this decayed building, it's a wonder that the giant spiders who make these messes seem to have been cleared out. Then what, you wonder, has taken this place over in their stead? You should be wary."

/area/f13/building/coyote/nash/school/groundfloor
	narrate = "The stench of rotting wood smashes you in the face like a hammer as you pass into this creaking building. Rot, rust, decay and ruin fill these dark hallways. No more do the teenagers of the city seek to learn from this hallowed ground, only death waits within. Faintly, you can hear something on one of the upper floors. Something heavy. Perhaps, though, it is your imagination run wild."

/area/f13/building/coyote/nash/firestation
	narrate = "This place was once home to the heroes that would help fight fires in the city. It's a shame that the fire that killed all them wasn't one a waterhose could put out. Now all that remains is a dark, slightly dank, husk of a building. The trucks, if you even know what those are, are long gone. Torn apart for no one knows what, but it does seem to have been made into a residence for some creatures of the waste."

/area/f13/building/coyote/nash/mall/groundfloor
	narrate = "You've stumbled into the largest building you can find in the city. This was once the Texarkana Central Mall. Now it's little more than a nest for monsters, raiders, and no one knows what else. Perhaps, if you are lucky, you can pick through what remains and find something worthwhile. Or perhaps work your way up, though, even from down here you can hear the hollering yells of mutants above, they likely saw you come inside and are hoping to ambush you on the roof. Or, maybe that's the wind."

/area/f13/building/coyote/nash/massfus/parkinglot
	narrate = "You've pushed into the parking lot of the gigantic power plant that used to run the city. Perhaps you know what it is, perhaps you don't. The stench of molerat feces is strong, the creatures seem to be about in large numbers. Perhaps, if you're smart enough, you ponder if the systems leaked into the ground water and caused the molerats to find this area so comfortable. Or perhaps you only care to slay the monsters and seek what is inside. No matter which option, the gigantic cooling tower at the center of the facility looms over you with a shadow that stretches far. Enter with caution."

/area/f13/building/coyote/nash/massfus/sidebuilding
	narrate = "The door to this facility, somehow still powered, slid out of your way with a mechanical hiss and whirr. Inside you find what you likely found outside. More molerats. An infestation of which the scale can not be simply explained. It has to be seen. Smelled. Tasted. This building sure is an assault on your senses of smell, and the taste is going to linger in your nostrils for a long time. Even if all the molerats are gone. Are they?"

/area/f13/building/coyote/nash/massfus/workshop
	narrate = "The door that just clicked and whirred itself open barely works, its track causing it to jump before it returns to it's centered position. This building is still powered, and smells much less of molerat than the other's in the parking lot. Instead the smell of old oil lingers, of cigarette smoke, and long hours. The ghosts of men long dead would haunt this realm, still wishing to see their families and finish their days work. If you believe in that sort of thing. If not, then the tools they once used are certainly left behind. To the living go the spoils."

/area/f13/building/coyote/nash/massfus/lobby
	narrate = "The sign in the middle of the lobby says it all. Clearly written in blood, 'fuk off'. Whoever lives here doesn't want you here either. Though, it seems this lobby branches off to the left and right. Choices to be made. One thing is for certain, you do not feel safe. This place is very dangerous. Perhaps you should have brought a friend?"

/area/f13/building/coyote/nash/massfus/groundfloor/east
	narrate = "The eastern part of the facility. Immediatly your sense of smell is hit with what can best be described as 'dirty water'. Which makes sense, you can hear a lot of sloshing and the faint sounds of clicking. Go with caution, something isn't right."

/area/f13/building/coyote/nash/massfus/groundfloor/west
	narrate = "The western part of the ground floor of the Mass Fusion power plant. Even in this room you can smell burnt cordite and, while well lit you really wish it wasn't. Unless of course you revel in the sight of what is likely human blood and viscera smeared around as if by the hands of an expert janitor. The people within this place, if they do still live, are not worth tarrying with. Danger, and perhaps golden nuggets of the age past lay ahead of you. If you can survive to bring them home."

/area/f13/building/coyote/nash/massfus/upperfloor
	narrate = "You can hear the raiders talking, even as you step off the metal stairs. Or perhaps its the memories of them still lingering in this area. Intution tells you to be careful, and take it slow. This will be a marathon, not a sprint. You really should have brought a friend, if you didn't."


//Underground
/area/f13/underground/cave/coyote
	narrate = "You feel a subtle dread. Something here feels wrong. The world is unrealized for a brief moment; a thin tarp concealing a reality you can't experience, nor want to. You think you might feel safer if you had lots of friends and supplies."

/area/f13/underground/cave/coyote/antmound
	narrate = "This cave smells like a mixture of petrolium products mixed with a lemony, almost citrus, scent. If you're clever you know it as formic acid. It's the smell of ants, and something flamable. Be careful here, you are in their home and they know these tunnels well."

// (Relative) Safety

/area/f13/building/coyote/safe
	name = "Unknown Portal Storm Shelter" // this is relevant since the beacon says the name of whatever area it's within
	narrate = "This old storm shelter was refitted to provide safety and (meager) supplies to those that hide within. Rest your eyes, traveller, this is one of the few truly safe spaces."
	narrate_sound = 'sound/ambience/ambitech.ogg'

/area/f13/building/coyote/safe/nash
	name = "Nash Portal-Storm Shelter"

/area/f13/building/coyote/safe/ashdown
	name = "Ashdown Portal-Storm Shelter"

/area/f13/building/coyote/safe/garland
	name = "Garland Portal-Storm Shelter"

/area/f13/building/coyote/safe/redwater
	name = "Redwater Portal-Storm Shelter"

/area/f13/building/coyote/safe/fortredwater
	name = "Fort Redwater Portal-Storm Shelter"

/area/f13/building/coyote/safe/den
	name = "Den Portal-Storm Shelter"

/area/f13/building/coyote/safe/trats
	name = "Tunnel Rats Portal-Storm Shelter"

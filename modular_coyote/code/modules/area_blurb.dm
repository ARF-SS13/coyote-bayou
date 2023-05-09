/area/

	var/narrate //A text-based description of what this area is for.
	var/list/blurbed_stated_to = list() //This list of names is here to make sure we don't state our descriptive blurb to a person more than once.



/area/proc/do_area_blurb(var/mob/living/L)
	if(isnull(narrate))
		return
/* //not using preferences, here
	if(L?.get_preference_value(/datum/client_preference/area_info_blurb) != GLOB.PREF_YES)
		return
*/
	if(!(L.ckey in blurbed_stated_to))
		blurbed_stated_to += L.ckey
		to_chat(L, span_warning("[narrate]"))


/************
OKAY SO HERE'S HOW THIS WORKS

We have an area. When someone enters the area, it throws up a description.
The var is 'narrate'.

/area/f13/tunnel/bighorn
	name = "\improper Bighorn Underground"
	narrate = "" < This is the important line.

ty ilu - bear
*/

/area/f13/building
	narrate = "Test narrate. You've yee'd your last haw here, pardner."
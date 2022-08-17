/*
basically Baystation's character flavor text edited to work with /tg/ code.

flavor_text is loaded and saved for player savegames as part of DNA, in
	code\modules\client\preferences.dm
and can only be edited by players during character setup, in
	code\modules\client\preferences_savefile.dm

it is transfered from DNA to human mobs (on a carbon mob level) in
	code\datums\dna.dm
whenever needed.

the two main player-facing functionalities are:
	A) adding a short (with Topic-link) version of the text to human examine() output, in
		code\modules\mob\living\carbon\human\examine.dm

	B) showing the full text in a window via human Topic() call, in
		code\modules\mob\living\carbon\human\human.dm

in general these two functionalities could be added to any kind of mob's examine() and Topic(),
you would need to add a way (e.g. verb) for the mobs to set the text as they do not have access to the character setup screen,
but I am not sure you even want non-humans to have it (not even Bay does that), so no tragic backstory for cleanbots for now.
*/

///mob/var/flavor_text = ""

///mob/proc/print_flavor_text()
//	if(flavor_text && flavor_text != "")
		// We are decoding and then encoding to not only get correct amount of characters, but also to prevent partial escaping characters being shown.
//		var/msg = html_decode(replacetext(flavor_text, "\n", " "))
//		if(length(msg) <= 40)
//			return span_notice("[html_encode(msg)]")
//		else
//			return "<span class='notice'>[html_encode(copytext(msg, 1, 37))]... <a href='?src=[REF(src)];flavor_more=1'>More...</span></a>"

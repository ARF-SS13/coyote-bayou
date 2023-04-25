/////////////////////////////////////////////
//// cool angled line 
/////////////////////////////////////////////

/// Generates a scaled line starting at a turf and extending for a fixed length in a given angle
/datum/effect_fancy/line_effect
	index = EFFECT_LINE_EFFECT
	var/obj/effect/temp_visual/lineholder/myline = /obj/effect/temp_visual/lineholder

/// Generates a scaled line starting at a turf and extending for a fixed length in a given angle
/datum/effect_fancy/line_effect/do_effect(turf/start, turf/end, angle, length)
	if(!start || !end)
		return
	var/obj/effect/temp_visual/lineholder/the_line = new myline(get_turf(start))
	/// now, a bunch of math and matrix stuff to get the line to the right place
	/// First, scale the line to the right length
	/// convert the length in pixels to a scale factor, 32 pixels = 1 unit
	var/scale_by = length / 32
	var/matrix/M = the_line.transform
	M = M.Scale(1, scale_by)
	/// Now, translate the line down by 32 * ((scale_by + 1) / 2) pixels
	/// This is because the line is anchored at the top left corner, so we need to move it down by half its length
	/// We also need to move it down by 32 pixels, because the line is anchored at the top left corner
	M = M.Translate(0, 32 * ((scale_by + 1) / 2))
	/// Now, rotate the line by the angle
	M = M.Turn(angle)
	the_line.transform = M

/obj/effect/temp_visual/lineholder
	icon = 'icons/effects/effects.dmi'
	icon_state = "spear"
	duration = 0.3 SECONDS

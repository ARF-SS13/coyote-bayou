/// TAIL HUD~
/// Purely because asses eat tails while facing north
/// 

/datum/atom_hud/data/human/tail
	hud_icons = list(TAIL_HUD)

//Takes in the tail FRONT sprite and updates our sprite to look like it
/mob/living/proc/tail_hud_update(image/the_tail)
	if(!islist(hud_list))
		prepare_huds()
	if(!the_tail) // dunno why not having a tail gives you a random tail, but hey
		the_tail = image('icons/mob/hud.dmi', src, "")
		the_tail.appearance_flags = RESET_COLOR|RESET_TRANSFORM
	var/image/tail_north = hud_list[TAIL_HUD]
	tail_north.icon = the_tail.icon
	tail_north.icon_state = the_tail.icon_state
	tail_north.color = the_tail.color
	tail_north.pixel_x = the_tail.pixel_x
	tail_north.pixel_y = the_tail.pixel_y
	tail_north.loc = src
	tail_north.layer = layer+3 // idfk

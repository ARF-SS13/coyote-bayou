/datum/component/spawner/ranged
	var/range = 10 /// The minimum distance to a client before we can start spawning mobs.

/datum/component/spawner/ranged/Initialize(_mob_types, _spawn_time, _faction, _spawn_text, _max_mobs, _spawn_sound = null, _infinite = TRUE, _range = null)
	if((. = ..(_mob_types, _spawn_time, _faction, _spawn_text, _max_mobs, _spawn_sound = _spawn_sound, _infinite = _infinite)) == COMPONENT_INCOMPATIBLE)
		return
	if(_range)
		range = _range

/datum/component/spawner/ranged/try_spawn_mob()
	var/atom/atom_parent = parent
	var/is_close_enough = FALSE
	for(var/mob/living as anything in SSmobs.clients_by_zlevel[atom_parent.z]) // client-containing mobs, NOT clients
		if(get_dist(atom_parent, living) <= range)
			is_close_enough = TRUE
			break
	if(is_close_enough)
		return ..()
	else
		return FALSE

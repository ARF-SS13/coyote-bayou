/datum/spawners_menu
	var/mob/dead/observer/owner

/datum/spawners_menu/New(mob/dead/observer/new_owner)
	if(!istype(new_owner))
		qdel(src)
	owner = new_owner

/datum/spawners_menu/Destroy(force, ...)
	owner = null
	return ..()

/datum/spawners_menu/ui_state(mob/user)
	return GLOB.observer_state

/datum/spawners_menu/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "SpawnersMenu")
		ui.open()

/datum/spawners_menu/ui_data(mob/user)
	var/list/data = list()
	data["spawners"] = list()
	var/players_on = living_player_count()
	for(var/spawner in GLOB.mob_spawners)
		var/list/this = list()
		this["name"] = spawner
		this["short_desc"] = ""
		this["flavor_text"] = ""
		this["important_warning"] = ""
		this["refs"] = list()
		var/num_available = LAZYLEN(GLOB.mob_spawners[spawner])
		for(var/spawner_obj in GLOB.mob_spawners[spawner])
			if(istype(spawner_obj, /mob/living/simple_animal))
				var/mob/living/simple_animal/this_thing = spawner_obj
				if(!(this_thing.z in COMMON_Z_LEVELS))
					num_available--
					continue
				if(this_thing.pop_required_to_jump_into > players_on && (!this_thing.lazarused))
					num_available--
					continue
			this["refs"] += "[REF(spawner_obj)]"
			if(!this["desc"])
				if(istype(spawner_obj, /obj/effect/mob_spawn))
					var/obj/effect/mob_spawn/MS = spawner_obj
					this["short_desc"] = MS.short_desc
					this["flavor_text"] = MS.flavour_text
					this["important_info"] = MS.important_info
				else if(istype(spawner_obj, /mob/living/simple_animal))
					var/mob/living/simple_animal/aminol = spawner_obj
					this["short_desc"] = aminol.desc_short
					this["desc"] = aminol.desc
					this["flavor_text"] = aminol.desc
					if(aminol.lazarused)
						this["important_info"] = "This creature is tamed, and is bound to follow the commands of who/what had tamed them!"
					else if(aminol.pop_required_to_jump_into < players_on)
						this["important_info"] = "This creature's abilities are somewhat limited while Nash sleeps."
					else
						this["important_info"] = aminol.desc_important
				else
					var/atom/O = spawner_obj
					this["desc"] = O.desc
		if(num_available <= 0)
			continue
		this["amount_left"] = LAZYLEN(GLOB.mob_spawners[spawner])
		data["spawners"] += list(this)

	return data

/datum/spawners_menu/ui_act(action, params)
	if(..())
		return

	var/group_name = params["name"]
	if(!group_name || !(group_name in GLOB.mob_spawners))
		return
	var/list/spawnerlist = GLOB.mob_spawners[group_name]
	if(!spawnerlist.len)
		return
	var/atom/MS = pick(spawnerlist)
	if(!istype(MS))
		return
	switch(action)
		if("jump")
			if(MS)
				owner.forceMove(get_turf(MS))
				. = TRUE
		if("spawn")
			// first check if there's a ghostable mob on your turf, and try and insert urself into it
			var/mob/living/simple_animal/SA = locate(/mob/living/simple_animal) in get_turf(owner)
			if(istype(SA))
				owner.forceMove(get_turf(SA))
				SA.attack_ghost(owner)
				. = TRUE
			else if(MS)
				owner.forceMove(get_turf(MS))
				MS.attack_ghost(owner)
				. = TRUE

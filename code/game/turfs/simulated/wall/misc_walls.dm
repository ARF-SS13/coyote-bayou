/turf/closed/wall/mineral/cult
	name = "runed metal wall"
	desc = "A cold metal wall engraved with indecipherable symbols. Studying them causes your head to pound."
	icon = 'icons/turf/walls/cult_wall.dmi'
	icon_state = "cult_wall-0"
	base_icon_state = "cult_wall"
	smoothing_flags = SMOOTH_BITMASK
	canSmoothWith = null
	sheet_type = /obj/item/stack/sheet/runed_metal
	sheet_amount = 1
	explosion_block = 10
	girder_type = /obj/structure/girder/cult

/turf/closed/wall/mineral/cult/Initialize()
	new /obj/effect/temp_visual/cult/turf(src)
	. = ..()

/turf/closed/wall/mineral/cult/devastate_wall()
	new sheet_type(get_turf(src), sheet_amount)

/turf/closed/wall/mineral/cult/Exited(atom/movable/AM, atom/newloc)
	. = ..()
	if(istype(AM, /mob/living/simple_animal/hostile/construct/harvester)) //harvesters can go through cult walls, dragging something with
		var/mob/living/simple_animal/hostile/construct/harvester/H = AM
		var/atom/movable/stored_pulling = H.pulling
		if(stored_pulling)
			stored_pulling.setDir(get_dir(stored_pulling.loc, newloc))
			stored_pulling.forceMove(src)
			H.start_pulling(stored_pulling, supress_message = TRUE)

/turf/closed/wall/mineral/cult/ratvar_act()
	. = ..()
	if(istype(src, /turf/closed/wall/mineral/cult)) //if we haven't changed type
		var/previouscolor = color
		color = "#FAE48C"
		animate(src, color = previouscolor, time = 8)
		addtimer(CALLBACK(src, /atom/proc/update_atom_colour), 8)

/turf/closed/wall/mineral/cult/artificer
	name = "runed stone wall"
	desc = "A cold stone wall engraved with indecipherable symbols. Studying them causes your head to pound."

/turf/closed/wall/mineral/cult/artificer/break_wall()
	new /obj/effect/temp_visual/cult/turf(get_turf(src))
	return null //excuse me we want no runed metal here

/turf/closed/wall/mineral/cult/artificer/devastate_wall()
	new /obj/effect/temp_visual/cult/turf(get_turf(src))

//Clockwork wall: Causes nearby tinkerer's caches to generate components.
/*/turf/closed/wall/clockwork
	name = "clockwork wall"
	desc = "A huge chunk of warm metal. The clanging of machinery emanates from within."
	explosion_block = 5
	hardness = 10
	slicing_duration = 80
	sheet_type = /obj/item/stack/tile/brass
	sheet_amount = 1
	girder_type = /obj/structure/destructible/clockwork/wall_gear
	baseturfs = /turf/open/floor/clockwork/reebe
	var/heated
	var/obj/effect/clockwork/overlay/wall/realappearance

/turf/closed/wall/clockwork/Initialize()
	. = ..()
	new /obj/effect/temp_visual/ratvar/wall(src)
	new /obj/effect/temp_visual/ratvar/beam(src)
	realappearance = new /obj/effect/clockwork/overlay/wall(src)
	realappearance.linked = src

/turf/closed/wall/clockwork/Destroy()
	if(realappearance)
		qdel(realappearance)
		realappearance = null
	if(heated)
		var/mob/camera/eminence/E = get_eminence()
		if(E)
			E.superheated_walls--

	return ..()

/turf/closed/wall/clockwork/rcd_vals(mob/user, obj/item/construction/rcd/the_rcd)
	if(heated && the_rcd.canRturf)
		return ..()

/turf/closed/wall/clockwork/rcd_act(mob/user, obj/item/construction/rcd/the_rcd, passed_mode)
	if(heated && the_rcd.canRturf)
		return ..()

/turf/closed/wall/clockwork/try_destroy(obj/item/I, mob/user, turf/T)
	if(!heated)
		return ..()
	if(!istype(I, /obj/item/pickaxe/drill/jackhammer))
		return FALSE
	to_chat(user, span_notice("You begin to smash though [src]..."))
	if(!do_after(user, 70, TRUE, src))
		return FALSE
	I.play_tool_sound(src)
	visible_message(span_warning("[user] smashes through [src] with [I]!"), span_italic("You hear the grinding of metal."))
	dismantle_wall()
	return TRUE

/turf/closed/wall/clockwork/ReplaceWithLattice()
	..()
	for(var/obj/structure/lattice/L in src)
		L.ratvar_act()

/turf/closed/wall/clockwork/narsie_act()
	..()
	if(istype(src, /turf/closed/wall/clockwork)) //if we haven't changed type
		var/previouscolor = color
		color = "#960000"
		animate(src, color = previouscolor, time = 8)
		addtimer(CALLBACK(src, /atom/proc/update_atom_colour), 8)

/turf/closed/wall/clockwork/dismantle_wall(devastated=0, explode=0)
	if(devastated)
		devastate_wall()
		ScrapeAway()
	else
		playsound(src, 'sound/items/welder.ogg', 100, 1)
		var/newgirder = break_wall()
		if(newgirder) //maybe we want a gear!
			transfer_fingerprints_to(newgirder)
		ScrapeAway()

	for(var/obj/O in src) //Eject contents!
		if(istype(O, /obj/structure/sign/poster))
			var/obj/structure/sign/poster/P = O
			P.roll_and_drop(src)
		else
			O.forceMove(src)

/turf/closed/wall/clockwork/devastate_wall()
	for(var/i in 1 to 2)
		new/obj/item/clockwork/alloy_shards/large(src)
	for(var/i in 1 to 2)
		new/obj/item/clockwork/alloy_shards/medium(src)
	for(var/i in 1 to 3)
		new/obj/item/clockwork/alloy_shards/small(src)

/turf/closed/wall/clockwork/attack_hulk(mob/living/user, does_attack_animation = 0)
	..()
	if(heated)
		to_chat(user, span_userdanger("The wall is searing hot to the touch!"))
		user.adjustFireLoss(5)
		playsound(src, 'sound/machines/fryer/deep_fryer_emerge.ogg', 50, TRUE)

/turf/closed/wall/clockwork/mech_melee_attack(obj/mecha/M)
	..()
	if(heated)
		to_chat(M.occupant, span_userdanger("The wall's intense heat completely reflects your [M.name]'s attack!"))
		M.take_damage(20, BURN)

/turf/closed/wall/clockwork/proc/turn_up_the_heat()
	if(!heated)
		name = "superheated [name]"
		visible_message(span_warning("[src] sizzles with heat!"))
		playsound(src, 'sound/machines/fryer/deep_fryer_emerge.ogg', 50, TRUE)
		heated = TRUE
		hardness = -100 //Lower numbers are tougher, so this makes the wall essentially impervious to smashing
		slicing_duration = 150
		animate(realappearance, color = "#FFC3C3", time = 5)
	else
		name = initial(name)
		visible_message(span_notice("[src] cools down."))
		heated = FALSE
		hardness = initial(hardness)
		slicing_duration = initial(slicing_duration)
		animate(realappearance, color = initial(realappearance.color), time = 25)
*/

/turf/closed/wall/vault
	name = "vault wall"
	desc = "An airtight metal wall with decorative blue-and-gold plating."
	icon = 'icons/turf/walls/wall_vault.dmi'

/turf/closed/wall/ice
	icon = 'icons/turf/walls/icedmetal_wall.dmi'
	icon_state = "icedmetal_wall-0"
	base_icon_state = "icedmetal_wall"
	desc = "A wall covered in a thick sheet of ice."
	smoothing_flags = SMOOTH_BITMASK
	canSmoothWith = null
	hardness = 35
	slicing_duration = 150 //welding through the ice+metal
	bullet_sizzle = TRUE

/turf/closed/wall/rust
	name = "rusted wall"
	desc = "A rusted metal wall."
	icon = 'icons/turf/walls/rusty_wall.dmi'
	icon_state = "wall-0"
	base_icon_state = "wall"
	smoothing_flags = SMOOTH_BITMASK
	hardness = 45

/turf/closed/wall/rust/rust_heretic_act()
	ScrapeAway()

/turf/closed/wall/r_wall/rust
	name = "rusted reinforced wall"
	desc = "A huge chunk of rusted reinforced metal."
	icon = 'icons/turf/walls/rusty_reinforced_wall.dmi'
	icon_state = "wall-0"
	base_icon_state = "wall"
	smoothing_flags = SMOOTH_BITMASK
	hardness = 15

/turf/closed/wall/r_wall/rust/rust_heretic_act()
	if(prob(50))
		return
	ScrapeAway()

/turf/closed/wall/mineral/bronze
	name = "clockwork wall"
	desc = "A huge chunk of bronze, decorated like gears and cogs."
	icon = 'icons/turf/walls/clockwork_wall.dmi'
	icon_state = "clockwork_wall-0"
	base_icon_state = "clockwork_wall"
	smoothing_flags = SMOOTH_BITMASK
	sheet_type = /obj/item/stack/sheet/bronze
	sheet_amount = 2
	girder_type = /obj/structure/girder/bronze

/turf/closed/wall/corrugated
	name = "corrugated metal wall"
	desc = "A metal wall made out of extremely widely available corrugated iron sheets. Just slap the onto some supports and you have your very own rickety wall!"
	icon = 'icons/turf/walls/corrugated_wall.dmi'
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_CORRUGATED_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_CORRUGATED_WALLS)

/turf/closed/wall/corrugated/red
	name = "red corrugated metal wall"
	desc = "A hastily slapped-together FAST wall, it's really fast! Because it's painted red."
	icon = 'icons/turf/walls/corrugated_wall_red.dmi'

/turf/closed/wall/corrugated/green
	name = "green corrugated metal wall"
	desc = "A dark-green corrugated sheet wall. Woah, is this a stealth barn? You could hide this in a field and no one would ever find it!"
	icon = 'icons/turf/walls/corrugated_wall_green.dmi'

/turf/closed/wall/corrugated/blue
	name = "blue corrugated metal wall"
	desc = "Super-common corrugated sheets slapped onto a frame, a wall! It gives off an aura of Pantone 7545C... or is it Pantone 7546C? Perhaps the radiation is interfering with my interior decorating knowledge..."
	icon = 'icons/turf/walls/corrugated_wall_blue.dmi'

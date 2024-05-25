//Nuclear particle projectile - a deadly side effect of fusion
/obj/item/projectile/energy/nuclear_particle
	name = "nuclear particle"
	icon_state = "nuclear_particle"
	pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE
	flag = "rad"
	irradiate = 500
	pixels_per_second = TILES_TO_PIXELS(25)
	hitsound = 'sound/weapons/emitter2.ogg'
	impact_type = /obj/effect/projectile/impact/xray
	light_system = MOVABLE_LIGHT
	light_range = 4
	light_power = 3
	var/static/list/particle_colors = list(
		"red" = "#FF0000",
		"blue" = "#00FF00",
		"green" = "#0000FF",
		"yellow" = "#FFFF00",
		"cyan" = "#00FFFF",
		"purple" = "#FF00FF"
	)

/obj/item/projectile/energy/nuclear_particle/Initialize()
	. = ..()
	//Random color time!
	var/our_color = pick(particle_colors)
	add_atom_colour(particle_colors[our_color], FIXED_COLOUR_PRIORITY)
	set_light_color(particle_colors[our_color]) //Range of 4, brightness of 3 - Same range as a flashlight

/atom/proc/fire_nuclear_particle(angle = rand(0,360)) //used by fusion to fire random nuclear particles. Fires one particle in a random direction.
	var/obj/item/projectile/energy/nuclear_particle/P = new /obj/item/projectile/energy/nuclear_particle(src)
	P.fire(angle)

/obj/item/projectile/energy/nuclear_particle/grenade
	name = "gamma particle"
	irradiate = 500

/obj/item/projectile/energy/nuclear_particle/cultist
	name = "morph ray"
	irradiate = 100


/obj/item/projectile/energy/nuclear_particle/plasmabounce
	name = "Toroidal Plasma Ball"
	icon_state = "plasma_bounce2"
	pass_flags = PASSTABLE
	flag = "energy"
	damage = 70
	irradiate = 0
	is_reflectable = TRUE
	movement_type = FLYING
	pixels_per_second = TILES_TO_PIXELS(15)
	hitsound = 'sound/weapons/emitter2.ogg'
	muzzle_type = /obj/effect/projectile/muzzle/laser/blue
	impact_type = /obj/effect/projectile/impact/laser/blue
	impact_effect_type = /obj/effect/temp_visual/impact_effect/ion
	ricochets_max = 10
	ricochet_chance = 100
	ricochet_auto_aim_angle = 70
	ricochet_auto_aim_range = 10
	ricochet_incidence_leeway = 0
	light_system = MOVABLE_LIGHT
	light_range = 4
	light_power = 3

/obj/item/projectile/energy/nuclear_particle/plasmabounce/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(ismob(target) )
		target.ex_act(EXPLODE_LIGHT)
		return

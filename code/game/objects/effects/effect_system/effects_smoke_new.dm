/////////////////////////////////////////////
//// cool smoke
/////////////////////////////////////////////

/// Makes a juicy cone of smoke starting at one turf and ending at another.
/datum/effect_fancy
	var/index

/datum/effect_fancy/proc/do_effect(turf/start, turf/end, params)
	return

/datum/effect_fancy/smoke_cone
	index = EFFECT_SMOKE_CONE
	var/obj/effect/particle_effect/fancy_smoke/smoke_type = /obj/effect/particle_effect/fancy_smoke
	var/max_distance = 5
	/// Probability to spawn a smoke on a given tile
	var/thickpercent = 100
	/// Probability to spawn a smoke on a given tile when it's on the side of the cone
	var/thickpercent_side = 75
	var/smoke_alpha = 255
	var/smoke_size = 100

/datum/effect_fancy/smoke_cone/small
	index = EFFECT_SMOKE_CONE_SMALL
	smoke_alpha = 85
	smoke_size = 80

/datum/effect_fancy/smoke_cone/do_effect(turf/start, turf/end, angle, length)
	if(!start || !end)
		return
	var/list/turfs = getline(start, end)
	/// An associated list all the turfs that we will put smoke on
	/// list format: list(turf = probability_of_spawning_smoke)
	var/list/validturfs = list()
	var/our_angle = Get_Angle(start, end)
	var/dir_left = angle2dir(turn(our_angle, 90))
	var/dir_right = angle2dir(turn(our_angle, -90))
	var/distance_cutoff = rand(FLOOR(max_distance*0.5, 1), max_distance)
	for(var/turf/T in turfs)
		if(get_dist(start, T) > distance_cutoff)
			break
		if(isclosedturf(T))
			break // hit a wall
		var/current_distance = max(get_dist(start, T), 1)
		/// As range increases, the probability of spawning smoke decreases, but only after a certain point
		var/side_prob = thickpercent_side / clamp(current_distance, 1, max_distance)

		validturfs[T] = 100 // we're always going to spawn smoke on the center line
		// grabs the turfs to the left and right of the line
		var/turf/left = get_step(T, dir_left)
		var/turf/right = get_step(T, dir_right)
		validturfs[left] = side_prob
		validturfs[right] = side_prob
		//if we're more than halfway to the destination, add in one more turf on either side of the turfs we just added
		if(get_dist(start, T) > (distance_cutoff * 0.5))
			var/turf/lefter = get_step(left, dir_left)
			var/turf/righter = get_step(right, dir_right)
			validturfs[lefter] = side_prob
			validturfs[righter] = side_prob
	for(var/turf/T in validturfs)
		if(prob(validturfs[T]))
			var/obj/effect/particle_effect/fancy_smoke/smonk = new smoke_type(T)
			smonk.base_alpha = smoke_alpha
			smonk.base_size = smoke_size
			smonk.start(get_dist(start, T))
		validturfs -= T // cleanup!

/obj/effect/particle_effect/fancy_smoke
	name = "smoke"
	icon = 'icons/effects/96x96.dmi'
	icon_state = "smoke2"
	pixel_x = -32
	pixel_y = -32
	opacity = 0
	layer = FLY_LAYER
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	animate_movement = 2
	/// How long the smoke will last
	var/lifetime = 10 SECONDS
	/// When the smoke started life, used to calculate transparency
	var/starttime = 0
	/// How quickly the smoke drifts around
	var/driftdelay = 28
	/// which direction the smoke drifts
	var/driftdir = NORTH
	/// distance_modifier is used to make smoke that's further away start off more transparent
	var/distance_modifier = 1
	var/base_alpha = 255
	var/base_size = 100

/// Sets up the smoke and starts it processing
/obj/effect/particle_effect/fancy_smoke/proc/start(distance_modifier = 1)
	START_PROCESSING(SSeffects, src)
	// checks if we're in an outside area, and sets our direction to the wind if we are
	var/area/A = get_area(src)
	if(A?.outdoors)
		driftdir = SSweather.wind_direction
		// if weather's happening, we're going to be moving a lot faster and lasting less time
		if(SSweather.current_weather)
			driftdelay *= 0.5
			lifetime *= 0.5
	else // if we're indoors, we're going to drift in a random direction
		driftdir = pick(GLOB.cardinals)
	src.distance_modifier = clamp(distance_modifier, 1, 3)
	driftdelay += rand(-driftdelay*0.5, driftdelay*0.5)
	set_glide_size(driftdelay)
	alpha = base_alpha / clamp(distance_modifier, 1, 3)
	transform = matrix(transform) * clamp(1 / max(distance_modifier + 1, 1), 0.5, 3) * (base_size / 100)
	INVOKE_ASYNC(src,PROC_REF(fade_out))
	walk(src, driftdir, driftdelay, 32)
	lifetime = rand(lifetime*0.5, lifetime*3)
	QDEL_IN(src, lifetime)

/obj/effect/particle_effect/fancy_smoke/Destroy()
	. = ..()
	STOP_PROCESSING(SSeffects, src)

/obj/effect/particle_effect/fancy_smoke/proc/fade_out()
	var/rotation_dir = pick(-1, 1)
	animate(
		src,
		alpha = 0,
		transform = turn(matrix(transform) * 3, rotation_dir * rand(90, 360)),
		time = lifetime,
		easing = CUBIC_EASING | EASE_OUT,
		flags = ANIMATION_PARALLEL)

/// Moves the smoke around every process
/obj/effect/particle_effect/fancy_smoke/process()
	var/turf/T = get_turf(src)
	if(!T)
		return
	var/turf/next_turf = get_step(T, driftdir)
	for(var/mob/living/carbon/C in next_turf)
		if(smoke_mob(C))
			return
	if(next_turf.density)
		driftdir = turn(driftdir, 90 * rand(-1, 1))
		walk(src, driftdir, driftdelay, 32)

/obj/effect/particle_effect/fancy_smoke/proc/smoke_mob(mob/living/carbon/C)
	if(!istype(C))
		return 0
	if(lifetime<1)
		return 0
	if(C.internal != null || C.has_smoke_protection())
		return 0
	if(C.smoke_delay)
		return 0
	C.smoke_delay++
	return TRUE

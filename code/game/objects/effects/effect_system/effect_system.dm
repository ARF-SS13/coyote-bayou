/* This is an attempt to make some easily reusable "particle" type effect, to stop the code
constantly having to be rewritten. An item like the jetpack that uses the ion_trail_follow system, just has one
defined, then set up when it is created with New(). Then this same system can just be reused each time
it needs to create more trails.A beaker could have a steam_trail_follow system set up, then the steam
would spawn and follow the beaker, even if it is carried or thrown.
*/


/obj/effect/particle_effect
	name = "particle effect"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	pass_flags = PASSTABLE | PASSGRILLE
	anchored = TRUE
	plane = MOB_PLANE //Patches all partical effects including spark to render over mobs

/obj/effect/particle_effect/Initialize()
	. = ..()
	GLOB.cameranet.updateVisibility(src)

/obj/effect/particle_effect/Destroy()
	GLOB.cameranet.updateVisibility(src)
	return ..()

/datum/effect_system
	var/number = 3
	var/cardinals = FALSE
	var/turf/location
	var/atom/holder
	var/effect_type
	var/total_effects = 0
	var/autocleanup = FALSE //will delete itself after use

/datum/effect_system/Destroy()
	holder = null
	location = null
	return ..()

/datum/effect_system/proc/set_up(n = 3, c = FALSE, loca)
	if(n > 10)
		n = 10
	number = n
	cardinals = c
	if(isturf(loca))
		location = loca
	else
		location = get_turf(loca)

/datum/effect_system/proc/attach(atom/atom)
	holder = atom

/datum/effect_system/proc/start()
	if(QDELETED(src))
		return
	for(var/i in 1 to number)
		if(total_effects > 20)
			return
		// INVOKE_ASYNC(src,PROC_REF(generate_effect)) // STOP FUCKING ASYNCING
		generate_effect()


/* // Replacing with modern bay's interpretation to see if this solves the intense amount of times it's called and the lag it makes due to the callback it uses.
/datum/effect_system/proc/generate_effect()
	if(holder)
		location = get_turf(holder)
	if(!location) //no location, no effects
		return
	if(location.contents.len > 200)		//Bandaid to prevent server crash exploit
		return
	var/obj/effect/E = new effect_type(location)
	total_effects++
	var/direction
	if(cardinals)
		direction = pick(GLOB.cardinals)
	else
		direction = pick(GLOB.alldirs)
	var/steps_amt = pick(1,2,3)
	for(var/j in 1 to steps_amt)
		sleep(5)
		step(E,direction)
	if(!QDELETED(src))
		addtimer(CALLBACK(src,PROC_REF(decrement_total_effect)), 20)
*/
/datum/effect_system/proc/generate_effect()
	if(holder)
		location = get_turf(holder)
	var/obj/effect/effect = new effect_type(location)
	total_effects++
	var/direction
	if(cardinals)
		direction = pick(GLOB.cardinals)
	else
		direction = pick(GLOB.alldirs)
	var/step_amt = pick(1,2,3)
	var/step_delay = 5

	var/datum/move_loop/loop = SSmove_manager.move(effect, direction, step_delay, timeout = step_delay * step_amt, priority = MOVEMENT_ABOVE_SPACE_PRIORITY)
	RegisterSignal(loop, COMSIG_PARENT_QDELETING,PROC_REF(decrement_total_effect))

/datum/effect_system/proc/decrement_total_effect()
	total_effects--
	if(autocleanup && total_effects <= 0)
		qdel(src)

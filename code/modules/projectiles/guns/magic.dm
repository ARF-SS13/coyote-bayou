#define MAGIC_DRAINED_BLOOD (1<<0)
#define MAGIC_DRAINED_HUNGER (1<<1)
#define MAGIC_DRAINED_BRUTE (1<<2)
#define MAGIC_DRAINED_BURN (1<<3)
#define MAGIC_DRAINED_TOXIN (1<<4)
/obj/item/gun/magic
	name = "staff of nothing"
	desc = "This staff is boring to watch because even though it came first you've seen everything it can do in other staves for years."
	icon = 'icons/obj/guns/magic.dmi'
	icon_state = "staffofnothing"
	item_state = "staff"
	lefthand_file = 'icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/staves_righthand.dmi'
	fire_sound = 'sound/weapons/emitter.ogg'
	weapon_class = WEAPON_CLASS_RIFLE
	flags_1 =  CONDUCT_1
	w_class = WEIGHT_CLASS_HUGE
	var/checks_antimagic = TRUE
	var/max_charges = 6
	var/charges = 0
	var/recharge_rate = 10 SECONDS
	var/charge_tick = 0
	var/can_charge = 1
	var/datum/looping_sound/wand_charge_1/soundloop
	var/ammo_type
	var/charge_timer
	var/no_den_usage = FALSE

	var/start_empty = FALSE

	/// Stuff for the Soul Cost, to drain stuff to fill up
	/// All of these need to be satisfied to gain a charge, so if they're all set, they all need to draw their cost
	/// How much blood do we drain for one charge?
	var/blood_drain_per_charge = 0
	var/blood_drained = 0
	/// How much hunger do we drain for one charge?
	var/hunger_drain_per_charge = 10
	var/hunger_drained = 0
	/// How much brute do we drain for one charge?
	var/brute_drain_per_charge = 0
	var/brute_drained = 0
	/// How much burn do we drain for one charge?
	var/burn_drain_per_charge = 0
	var/burn_drained = 0
	/// How much toxin do we drain for one charge?
	var/toxin_drain_per_charge = 0
	var/toxin_drained = 0
	/// How long should it take to drain for one charge?
	var/drain_duration_per_charge = 1 MINUTES
	/// last time we drained
	var/last_drain = 0
	/// multiplier for an emergency refill
	var/emergency_mult = 3
	/// currently draining
	var/draining_active = TRUE

	clumsy_check = FALSE
	trigger_guard = TRIGGER_GUARD_ALLOW_ALL // Has no trigger at all, uses magic instead
	pin = /obj/item/firing_pin/magic

/obj/item/gun/magic/Initialize()
	. = ..()
	if(!start_empty)
		charges = max_charges
	chambered = new ammo_type(src)
	soundloop = new(list(src), FALSE)
	if(draining_active)
		START_PROCESSING(SSprocessing, src)

/obj/item/gun/magic/Destroy()
	QDEL_NULL(soundloop)
	return ..()

/obj/item/gun/magic/examine(mob/user)
	. = ..()
	. += span_notice("Currently holds [charges] / [max_charges] kilovis.")
	if(can_charge)
		. += get_drain_examine_text()
		if(draining_active)
			. += span_alert("Currently sapping life force from nearby critters to charge itself! Use in hand if you want it stop.")
		else
			. += span_notice("Use in hand to allow it to sacrifice your life force to charge itself!")

/obj/item/gun/magic/update_icon_state()
	return // icon_prefix is buhhuuulllllshit and shouldnt be used

/obj/item/gun/magic/afterattack(atom/target, mob/living/user, flag)
	if(no_den_usage)
		var/area/A = get_area(user)
		if(istype(A, /area/wizard_station))
			to_chat(user, span_warning("You know better than to violate the security of The Den, best wait until you leave to use [src]."))
			return
		else
			no_den_usage = 0
	if(checks_antimagic && user.anti_magic_check(TRUE, FALSE, FALSE, 0, TRUE))
		to_chat(user, span_warning("Something is interfering with [src]."))
		return
	. = ..()

/obj/item/gun/magic/attack_self(mob/user)
	toggle_soul_drain(user)

/obj/item/gun/magic/can_shoot()
	return charges >= 1

/obj/item/gun/magic/recharge_newshot()
	if (chambered && !chambered.BB)
		chambered.newshot()

/obj/item/gun/magic/process_chamber()
	charges = max(charges - 1, 0) // deduct a charge
	recharge_newshot() // Make sure there's still a bullet in the chamber
	// start_charging() // Start charging a new shot

/obj/item/gun/magic/process()
	tick_drain()

/obj/item/gun/magic/proc/toggle_soul_drain(user)
	TOGGLE_VAR(draining_active)
	if(draining_active)
		START_PROCESSING(SSprocessing, src)
		to_chat(user, span_notice("You allow [src] to sacrifice your life force to charge itself!"))
	else
		STOP_PROCESSING(SSprocessing, src)
		to_chat(user, span_notice("[src] respects your wishes for it to stop draining life force, and stops draining life force."))

/obj/item/gun/magic/proc/tick_drain()
	if(!draining_active)
		STOP_PROCESSING(SSprocessing, src)
		return
	if(charges >= max_charges)
		return // all full =3
	var/turf/here = get_turf(src)
	if(!here) // uhh
		return // yeah
	var/mob/living/usermaybe = recursive_loc_path_search(src, /mob/living)
	var/mob/living/to_drain
	var/list/all_atoms_ever = here.contents - usermaybe
	if(usermaybe)
		all_atoms_ever.Insert(1, usermaybe) // put the user at the top of the list so we drain them if we dont find anyone
	// clever thing does like this: first try the mobs on the turf minus the user, then stuff inside the user, then the user if none are there
	var/tries = 50
	while(LAZYLEN(all_atoms_ever) && --tries)
		var/atom/A = all_atoms_ever[1]
		all_atoms_ever -= A
		if(isliving(A))
			var/mob/living/L = A
			if(L.stat == DEAD)
				continue // ded
			if((L.client || L.ckey) && L.stat < CONSCIOUS) // be merciful to players
				continue
			to_drain = L
			break
		if(A.contents)
			all_atoms_ever += A.contents
	if(!to_drain)
		return // >:{
	// okay found someone to drain! Let's do it!
	var/drain_mult = (1 SECONDS / max(SSprocessing.wait, 0.1)) * 10 // should be 1 second, so 10
	var/draint = NONE // bitflags of stuff we drained
	draint |= drain_blood(to_drain, drain_mult)
	draint |= drain_hunger(to_drain, drain_mult)
	draint |= drain_brute(to_drain, drain_mult)
	draint |= drain_burn(to_drain, drain_mult)
	draint |= drain_toxin(to_drain, drain_mult)
	if(blood_oath_satisfied())
		charges = min(charges + 1, max_charges)
		blood_drained = 0
		hunger_drained = 0
		brute_drained = 0
		burn_drained = 0
		toxin_drained = 0
		if(charges >= max_charges)
			full_charge_effect(to_drain, draint)
			if(soundloop)
				soundloop.stop()
			return
		partial_charge_effect(to_drain, draint)
		return
	passive_charge_effect(to_drain, draint)

/obj/item/gun/magic/proc/blood_oath_satisfied()
	if(blood_drained && (blood_drained < blood_drain_per_charge))
		return FALSE
	if(hunger_drained && (hunger_drained < hunger_drain_per_charge))
		return FALSE
	if(brute_drained && (brute_drained < brute_drain_per_charge))
		return FALSE
	if(burn_drained && (burn_drained < burn_drain_per_charge))
		return FALSE
	if(toxin_drained && (toxin_drained < toxin_drain_per_charge))
		return FALSE
	return TRUE

/obj/item/gun/magic/proc/drain_blood(mob/living/to_drain, drain_mult)
	if(!blood_drain_per_charge || (blood_drained >= blood_drain_per_charge))
		return FALSE
	var/amt_drain = min(round((blood_drain_per_charge / drain_duration_per_charge) * drain_mult, 0.01), blood_drain_per_charge - blood_drained)
	if(amt_drain <= 0)
		return FALSE
	if(ishuman(to_drain)) // nonhumans lack blood
		var/mob/living/carbon/human/scort = to_drain
		if(!(NOBLOOD in (scort.dna?.species?.species_traits))) // dey aint got no blood -- so they have blood
			scort.bleed(amt_drain)
			blood_drained += amt_drain
			return MAGIC_DRAINED_BLOOD
	/// okay we couldnt drain their blood, lets just punch em
	to_drain.adjustBruteLoss(amt_drain * 0.2)
	blood_drained += amt_drain
	return MAGIC_DRAINED_BRUTE

/obj/item/gun/magic/proc/drain_hunger(mob/living/to_drain, drain_mult)
	if(!hunger_drain_per_charge)
		return FALSE
	var/amt_drain = min(round((hunger_drain_per_charge / (drain_duration_per_charge)) * drain_mult, 0.01), hunger_drain_per_charge - hunger_drained)
	if(amt_drain <= 0)
		return FALSE
	if(ishuman(to_drain)) // nonhumans are unaffected by hunger
		if(!HAS_TRAIT(to_drain, TRAIT_NOHUNGER) && to_drain.nutrition >= amt_drain)
			to_drain.adjust_nutrition(-amt_drain)
			hunger_drained += amt_drain
			return MAGIC_DRAINED_HUNGER
	/// okay we couldnt drain their hunger, lets just poison em
	to_drain.adjustToxLoss(amt_drain * 0.2, ignore_toxin_lover = TRUE)
	hunger_drained += amt_drain
	return MAGIC_DRAINED_TOXIN

/obj/item/gun/magic/proc/drain_brute(mob/living/to_drain, drain_mult)
	if(!brute_drain_per_charge)
		return FALSE
	var/amt_drain = min(round((brute_drain_per_charge / (drain_duration_per_charge)) * drain_mult, 0.01), brute_drain_per_charge - brute_drained)
	if(amt_drain <= 0)
		return FALSE
	to_drain.adjustBruteLoss(amt_drain)
	brute_drained += amt_drain
	return MAGIC_DRAINED_BRUTE

/obj/item/gun/magic/proc/drain_burn(mob/living/to_drain, drain_mult)
	if(!burn_drain_per_charge)
		return FALSE
	var/amt_drain = min(round((burn_drain_per_charge / (drain_duration_per_charge)) * drain_mult, 0.01), burn_drain_per_charge - burn_drained)
	if(amt_drain <= 0)
		return FALSE
	to_drain.adjustFireLoss(amt_drain)
	burn_drained += amt_drain
	return MAGIC_DRAINED_BURN

/obj/item/gun/magic/proc/drain_toxin(mob/living/to_drain, drain_mult)
	if(!toxin_drain_per_charge)
		return FALSE
	var/amt_drain = min(round((toxin_drain_per_charge / (drain_duration_per_charge)) * drain_mult, 0.1), toxin_drain_per_charge - toxin_drained)
	if(amt_drain <= 0)
		return FALSE
	to_drain.adjustToxLoss(amt_drain, ignore_toxin_lover = TRUE)
	toxin_drained += amt_drain
	return MAGIC_DRAINED_TOXIN

/obj/item/gun/magic/proc/full_charge_effect(mob/living/to_drain, draint)
	audible_message(span_notice("[src] lets out a satisfied hum and stops devouring assorted life force."))

/obj/item/gun/magic/proc/partial_charge_effect(mob/living/to_drain, draint)
	audible_message(span_notice("[src] lets out a satisfied hum, but it is still hungry for life force."))

/obj/item/gun/magic/proc/passive_charge_effect(mob/living/to_drain, draint)
	return

/obj/item/gun/magic/proc/get_drain_examine_text()
	if(!blood_drain_per_charge && !hunger_drain_per_charge && !brute_drain_per_charge && !burn_drain_per_charge && !toxin_drain_per_charge)
		return "Uh oh! Error Code: GREEN-CRESTED-BLOOD-EAGLE, report this to a dev! =3"
	var/list/drain_text = list()
	drain_text += "To regain one kilovis, this thing needs to drain from you (or anyone you're standing on top of):"
	var/fully_charged = charges >= max_charges
	if(blood_drain_per_charge)
		if(fully_charged)
			drain_text += "\tBlood: [blood_drain_per_charge] units"
		else
			var/txt = "\tBlood: [blood_drained]/[blood_drain_per_charge] units"
			if(blood_drained >= blood_drain_per_charge)
				txt = span_green(txt)
			else
				txt = span_alert(txt)
			drain_text += txt
	if(hunger_drain_per_charge)
		if(fully_charged)
			drain_text += "\tHunger: [hunger_drain_per_charge] units"
		else
			var/txt = "\tHunger: [hunger_drained]/[hunger_drain_per_charge] units"
			if(hunger_drained >= hunger_drain_per_charge)
				txt = span_green(txt)
			else
				txt = span_alert(txt)
			drain_text += txt
	if(brute_drain_per_charge)
		if(fully_charged)
			drain_text += "\tBrute: [brute_drain_per_charge] units"
		else
			var/txt = "\tBrute: [brute_drained]/[brute_drain_per_charge] units"
			if(brute_drained >= brute_drain_per_charge)
				txt = span_green(txt)
			else
				txt = span_alert(txt)
			drain_text += txt
	if(burn_drain_per_charge)
		if(fully_charged)
			drain_text += "\tBurn: [burn_drain_per_charge] units"
		else
			var/txt = "\tBurn: [burn_drained]/[burn_drain_per_charge] units"
			if(burn_drained >= burn_drain_per_charge)
				txt = span_green(txt)
			else
				txt = span_alert(txt)
			drain_text += txt
	if(toxin_drain_per_charge)
		if(fully_charged)
			drain_text += "\tToxin: [toxin_drain_per_charge] units"
		else
			var/txt = "\tToxin: [toxin_drained]/[toxin_drain_per_charge] units"
			if(toxin_drained >= toxin_drain_per_charge)
				txt = span_green(txt)
			else
				txt = span_alert(txt)
			drain_text += txt
	drain_text += span_notice("\tOver the course of [drain_duration_per_charge] seconds.")
	if(draining_active)
		if(fully_charged)
			drain_text += span_green("It is currently fully charged, so it won't drain anything from you..... yet. Use it in hand if you want it to continue not doing that.")
		else
			drain_text += span_alert("It is currently draining life force from you (or anyone you're standing on). Use it in hand if you want it to stop doing that.")
	else
		drain_text += span_notice("It is currently quiet, so it won't drain anything from anyone. Use it in hand to change that.")
	drain_text += span_notice("Note, the draining will prioritize *any* creature in your tile over you, including creatures within containers, \
		that are being held by (or inside) you, or those you're within. If there is a creature anywhere in the tile that this thing happens to be, \
		it'll try to drain from them. Unless they're unconscious, then it'll pass them over. \n\
		Also note, you dont need to hold this thing for the drain to function, it'll happily work just lying on the ground, granted that there is something there to drain.\n\
		Go ahead, stamcrit a raider and stick it on top of em, see what happens!\n\
		-Love,\n\
		\tDan")
	return drain_text.Join("<br>")

/obj/item/gun/magic/proc/start_charging()
	if(charge_timer)
		return FALSE // Already charging
	if(!can_charge)
		return FALSE // Can't charge
	if(charges >= max_charges)
		return FALSE // Already full
	soundloop.start()
	charge_start_message()
	charge_timer = addtimer(CALLBACK(src, .proc/charge), recharge_rate, TIMER_UNIQUE|TIMER_STOPPABLE)

/obj/item/gun/magic/proc/charge()
	recharge_newshot()
	if(charges >= max_charges)
		charges = max_charges
		charge_full_message()
		soundloop.stop()
		charge_timer = null
		return FALSE
	charges++
	charge_partial_message()
	charge_timer = addtimer(CALLBACK(src, .proc/charge), recharge_rate, TIMER_UNIQUE|TIMER_STOPPABLE)

/obj/item/gun/magic/proc/charge_full_message()
	audible_message("[src] lets out a satisfied hum and falls quiet.")

/obj/item/gun/magic/proc/charge_partial_message()
	audible_message("[src] lets out a faint hum.")

/obj/item/gun/magic/proc/charge_start_message()
	audible_message("[src] begins letting out a soft hum.")

/obj/item/gun/magic/shoot_with_empty_chamber(mob/living/user as mob|obj)
	to_chat(user, span_warning("The [name] whizzles quietly."))

/obj/item/gun/magic/vv_edit_var(var_name, var_value)
	. = ..()
	switch(var_name)
		if(NAMEOF(src, charges))
			recharge_newshot()

/obj/item/gun/magic/ui_data(mob/user)
	var/list/data = ..()
	data["has_magazine"] = TRUE
	data["accepted_magazines"] = "You."
	data["magazine_name"] = "Magnetohydrodynamically stabilized transcendent spacetime tercel" // Its a magazine you silly goose
	data["magazine_calibers"] = "Your soul."
	data["shots_remaining"] = charges
	data["shots_max"] = max_charges
	return data

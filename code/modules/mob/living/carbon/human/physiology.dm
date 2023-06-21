//Stores several modifiers in a way that isn't cleared by changing species

/datum/physiology
	var/brute_mod = 1   	// % of brute damage taken from all sources
	var/burn_mod = 1    	// % of burn damage taken from all sources
	var/tox_mod = 1     	// % of toxin damage taken from all sources
	var/oxy_mod = 1     	// % of oxygen damage taken from all sources
	var/clone_mod = 1   	// % of clone damage taken from all sources
	var/stamina_mod = 1 	// % of stamina damage taken from all sources
	var/brain_mod = 1   	// % of brain damage taken from all sources

	var/pressure_mod = 1	// % of brute damage taken from low or high pressure (stacks with brute_mod)
	var/heat_mod = 1    	// % of burn damage taken from heat (stacks with burn_mod)
	var/cold_mod = 1    	// % of burn damage taken from cold (stacks with burn_mod)

	var/damage_resistance = 0 // %damage reduction from all sources

	var/siemens_coeff = 1 	// resistance to shocks

	var/stun_mod = 1      	// % stun modifier
	var/bleed_mod = 1     	// % bleeding modifier
	var/datum/armor/armor 	// internal armor datum

	var/hunger_mod = 1		//% of hunger rate taken per tick.

	var/do_after_speed = 1 //Speed mod for do_after. Lower is better. If temporarily adjusting, please only modify using *= and /=, so you don't interrupt other calculations.

	/// footstep type override for both shoeless and not footstep sounds.
	var/footstep_type
	var/mob/living/carbon/human/owner

/datum/physiology/New(mob/living/carbon/human/new_owner)
	armor = new
	owner = new_owner
	RegisterSignal(owner, COMSIG_ATOM_DEFENDER_OVERRIDES, .proc/modify_incoming_attack)

/datum/physiology/Del()
	owner = null
	UnregisterSignal(owner, COMSIG_ATOM_DEFENDER_OVERRIDES)
	. = ..()

/datum/physiology/proc/modify_incoming_attack(datum/source, mob/living/carbon/human/defender, atom/attacker, list/damage_list)
	if(!islist(damage_list)) // wont work otherwise
		return
	var/damage = GET_DAMAGE(damage_list)
	var/stamage = GET_STAMINA(damage_list)
	var/damage_type = GET_DAMAGE_TYPE(damage_list)
	switch(damage_type)
		if(BRUTE)
			damage *= brute_mod
		if(BURN)
			damage *= burn_mod
		if(TOX)
			damage *= tox_mod
		if(OXY)
			damage *= oxy_mod
		if(CLONE)
			damage *= clone_mod
		if(BRAIN)
			damage *= brain_mod
	stamage *= stamina_mod
	SET_STAMINA(damage_list, stamage)
	SET_DAMAGE(damage_list, damage)
	return TRUE

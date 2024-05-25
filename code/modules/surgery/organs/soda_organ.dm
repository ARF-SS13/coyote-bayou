#define SODIEHEAL_KIND_BRUTE (1 << 0)
#define SODIEHEAL_KIND_BURN  (1 << 1)
#define SODIEHEAL_KIND_TOX   (1 << 2)
#define SODIEHEAL_KIND_OXY   (1 << 3)
#define SODIEHEAL_KIND_BRAIN (1 << 4)
#define SODIEHEAL_KIND_CRIT  (1 << 5)
#define SODIEHEAL_RETURN_DEPLETED (1 << 6)
#define SODIE_MAX_AMOUNT 300 // max amount of sodie you can drink before further dranks subdract from th rest
#define SODIE_MIN_TIER_FOR_CRIT 2.1
#define SODIE_MIN_AMOUNT_FOR_CRIT (SODIE_MAX_AMOUNT * 0.95) // little wiggle room
#define SODIE_MAX_TIER 5 // sodie tiers are 1-5
#define SODIE_MIN_TIER 1
#define SODIEHEAL_MAX_BANK_PER_TIER 30 // max amount of banked heal per tier
#define SODIEHEAL_HEAL_PER_TIER 0.075 // heal per tier per second
#define SODIE_MSG_COOLDOWN 30 SECONDS

/obj/item/organ/sodie_organ
	name = "Gibb's organ"
	desc = "A thick spongy liver-like mass that spans across the abdomens of heavy sodie users, forming a blood-corpuscular osmotic membrane capable of transphosphorylating metasucroglycoglycolides found in your average sodie with acetoacetic acid into High Molecular Weight 7-4-Hydroxyanyl-3-Prenyl-Ribotolic acid (HMW4H3PR+) via a modified Dip-Kelly 4-Hydroxy-3-Prenyl-Ribose-5-Phosphate Reductase (HPR5PR) Electron Shunt Pathway. Or something. At any rate, it processes sodie into a slow, steady source of healing."
	icon_state = "liver"
	w_class = WEIGHT_CLASS_NORMAL
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_SODIE_ORGAN
	color = "#FF00FF" // pank as hell

	maxHealth = STANDARD_ORGAN_THRESHOLD
	healing_factor = STANDARD_ORGAN_HEALING
	decay_factor = STANDARD_ORGAN_DECAY

	high_threshold_passed = span_warning("You feel your insides tighten!")
	high_threshold_cleared = span_notice("The stitching ache in your abdomen passes away, unencumbering your movements.")
	now_fixed = span_notice("The stabbing pain in your abdomen slowly calms down into a more tolerable ache.")

	var/banked_brute = 0
	var/banked_burn = 0
	var/banked_tox = 0
	var/banked_oxy = 0
	var/banked_brain = 0
	/// last time we healed, to adjust for time
	var/last_heal = 0
	/// last time we sent a message to the player, to prevent spum
	var/last_msg = 0

	var/last_brute_max_msg = 0
	var/last_burn_max_msg = 0
	var/last_tox_max_msg = 0
	var/last_oxy_max_msg = 0
	var/last_brain_max_msg = 0

	/// if it uses its burst to heal you out of deep crit, it'll be busted for a good long time
	var/busted_till = 0

	/// So, you drink a sodie. The sodie has a tier score! This measures the average tier of the last 300 units if sodie you drank
	/// format: list(amount, amount, ...) // indexed by tier, pretty clever huh?
	var/list/drank = list(0,0,0,0,0) // 5 tiers
	/// But Dan, how're you gonna track the FILO order of the sodie you drank? Well, I'm glad you asked, because I'm not gonna!
	/// Instead, if we're at 300ish sodie drank, it'll just subtract an amount equal to the sodie volume processed from all the
	/// tiers *except* the one that was just drank. Pretty clever, huh?
	var/avg_tier = 0 // average tier of the last 300 sodie drank, cached when we process an sodie

	food_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/iron = 5)

/obj/item/organ/sodie_organ/on_life()
	. = ..()
	if(!. || !owner)//can't process reagents with a failing liver (but its a sodie organ)
		return
	var/healt = sodie_act()
	if(!healt)
		return
	var/dpletted = CHECK_BITFIELD(healt, SODIEHEAL_RETURN_DEPLETED)
	if(!dpletted && (!COOLDOWN_FINISHED(src, last_msg) || prob(90)))
		return
	COOLDOWN_START(src, last_msg, SODIE_MSG_COOLDOWN)
	if(CHECK_BITFIELD(healt, SODIEHEAL_KIND_BRUTE))
		to_chat(owner, span_good("You feel a faint shifting under your skin, and the pain in your bruises dulls a tiny bit."))
	if(CHECK_BITFIELD(healt, SODIEHEAL_KIND_BURN))
		to_chat(owner, span_good("You feel a faint shifting under your skin, and the pain in your burns dulls a tiny bit."))
	if(CHECK_BITFIELD(healt, SODIEHEAL_KIND_TOX))
		to_chat(owner, span_good("You feel an odd tingling in your veins, and your nausea subsides a tiny bit."))
	if(CHECK_BITFIELD(healt, SODIEHEAL_KIND_OXY))
		to_chat(owner, span_good("You feel an odd opening in your lungs, and your breathing becomes a tiny bit easier."))
	if(CHECK_BITFIELD(healt, SODIEHEAL_KIND_BRAIN))
		to_chat(owner, span_good("You feel a dull massaging in your brain, and your headache dulls a tiny bit."))
	if(dpletted)
		to_chat(owner, span_warning("Your organ feels a bit empty, and the sensation subsides. Maybe you should drink more sodie?"))

/obj/item/organ/sodie_organ/applyOrganDamage(d, maximum = maxHealth)
	. = ..()
	if(!. || QDELETED(owner))
		return

/obj/item/organ/sodie_organ/Insert(mob/living/carbon/M, special = FALSE, drop_if_replaced = TRUE)
	. = ..()
	RegisterSignal(M, COMSIG_CARBON_REAGENT_POST_LIFE,PROC_REF(bank_sauce))

/obj/item/organ/sodie_organ/Remove(special = FALSE)
	UnregisterSignal(owner, COMSIG_CARBON_REAGENT_POST_LIFE)
	return ..()

/obj/item/organ/sodie_organ/proc/sodie_act()
	if(QDELETED(owner))
		return
	if(!banked_brute && !banked_burn && !banked_tox && !banked_oxy && !banked_brain)
		return
	if(owner.health < HEALTH_THRESHOLD_FULLCRIT && !HAS_TRAIT(owner, TRAIT_NOHARDCRIT))
		if(squirt_crit())
			return SODIEHEAL_KIND_CRIT
	/// 0.1, times tier, times some kind of linear interpolation between 0 and 3 to compensate for time and normalize to per second
	var/healamt = round(SODIEHEAL_HEAL_PER_TIER * avg_tier * (SSmobs.wait/10), 0.01)
	/// if we're busted, we heal 4x slower
	if(busted_till > world.time)
		healamt \= 4
	/// now, find the lowest priority heal to heal, and heal it
	var/their_brain = owner.getOrganLoss(ORGAN_SLOT_BRAIN)
	if(their_brain > 0)
		if(banked_brain < healamt && prob(5)) // sliiiiight chance to convert some other type of banked squirt to this
			convert_banked_to(SODIEHEAL_KIND_BRAIN, healamt)
		if(banked_brain > 0)
			var/healby = min(banked_brain, healamt)
			owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, -healby)
			banked_brain = max(banked_brain - healby, 0)
			var/reat = SODIEHEAL_KIND_BRAIN | is_now_depleted(SODIEHEAL_KIND_BRAIN)
			if(owner.health < 0)
				. |= reat
			else
				return reat
	var/their_oxy = owner.getOxyLoss()
	if(their_oxy > 0)
		if(!banked_oxy && prob(5)) // sliiiiight chance to convert some other type of banked squirt to this
			convert_banked_to(SODIEHEAL_KIND_OXY, healamt)
		if(banked_oxy > 0)
			var/healby = min(banked_oxy, healamt)
			owner.adjustOxyLoss(-healby)
			banked_oxy = max(banked_oxy - healby, 0)
			var/reat = SODIEHEAL_KIND_OXY | is_now_depleted(SODIEHEAL_KIND_OXY)
			if(owner.health < 0)
				. |= reat
			else
				return reat
	var/their_tox = owner.getToxLoss()
	if(their_tox > 0)
		if(!banked_tox && prob(5)) // sliiiiight chance to convert some other type of banked squirt to this
			convert_banked_to(SODIEHEAL_KIND_TOX, healamt)
		if(banked_tox > 0)
			var/healby = min(banked_tox, healamt)
			owner.adjustToxLoss(-healby, force_be_heal = TRUE) // toxin lovers suffer (cutely)
			banked_tox = max(banked_tox - healby, 0)
			return SODIEHEAL_KIND_TOX | is_now_depleted(SODIEHEAL_KIND_TOX)
	var/their_burn = owner.getFireLoss(FALSE)
	if(their_burn > 0)
		if(!banked_burn && prob(5)) // sliiiiight chance to convert some other type of banked squirt to this
			convert_banked_to(SODIEHEAL_KIND_BURN, healamt)
		if(banked_burn > 0)
			var/healby = min(banked_burn, healamt)
			owner.adjustFireLoss(-healby)
			banked_burn = max(banked_burn - healby, 0)
			return SODIEHEAL_KIND_BURN | is_now_depleted(SODIEHEAL_KIND_BURN)
	var/their_brute = owner.getBruteLoss(FALSE)
	if(their_brute > 0)
		if(!banked_brute && prob(5)) // sliiiiight chance to convert some other type of banked squirt to this
			convert_banked_to(SODIEHEAL_KIND_BRUTE, healamt)
		if(banked_brute > 0)
			var/healby = min(banked_brute, healamt)
			owner.adjustBruteLoss(-min(banked_brute, healamt))
			banked_brute = max(banked_brute - healby, 0)
			return SODIEHEAL_KIND_BRUTE | is_now_depleted(SODIEHEAL_KIND_BRUTE)
	return FALSE

/obj/item/organ/sodie_organ/proc/convert_banked_to(kind, amount)
	if(!kind)
		return
	var/list/allkinds = list("brute", "burn", "tox", "oxy", "brain")
	if(!(kind in allkinds))
		return
	allkinds -= kind
	var/succ_amt = (amount / max(LAZYLEN(allkinds), 1))
	var/to_add = 0
	for(var/damheal in allkinds)
		switch(damheal)
			if(SODIEHEAL_KIND_BRUTE)
				to_add = min(banked_brute, succ_amt)
				banked_brute = max(banked_brute - succ_amt, 0)
			if(SODIEHEAL_KIND_BURN)
				to_add = min(banked_burn, succ_amt)
				banked_burn = max(banked_burn - succ_amt, 0)
			if(SODIEHEAL_KIND_TOX)
				to_add = min(banked_tox, succ_amt)
				banked_tox = max(banked_tox - succ_amt, 0)
			if(SODIEHEAL_KIND_OXY)
				to_add = min(banked_oxy, succ_amt)
				banked_oxy = max(banked_oxy - succ_amt, 0)
			if(SODIEHEAL_KIND_BRAIN)
				to_add = min(banked_brain, succ_amt)
				banked_brain = max(banked_brain - succ_amt, 0)
	switch(kind)
		if(SODIEHEAL_KIND_BRUTE)
			banked_brute += to_add
		if(SODIEHEAL_KIND_BURN)
			banked_burn += to_add
		if(SODIEHEAL_KIND_TOX)
			banked_tox += to_add
		if(SODIEHEAL_KIND_OXY)
			banked_oxy += to_add
		if(SODIEHEAL_KIND_BRAIN)
			banked_brain += to_add
	return !!to_add

/obj/item/organ/sodie_organ/proc/is_now_depleted(kind)
	if(!kind)
		return FALSE
	switch(kind)
		if(SODIEHEAL_KIND_BRUTE)
			return !!!banked_brute * SODIEHEAL_RETURN_DEPLETED
		if(SODIEHEAL_KIND_BURN)
			return !!!banked_burn * SODIEHEAL_RETURN_DEPLETED
		if(SODIEHEAL_KIND_TOX)
			return !!!banked_tox * SODIEHEAL_RETURN_DEPLETED
		if(SODIEHEAL_KIND_OXY)
			return !!!banked_oxy * SODIEHEAL_RETURN_DEPLETED
		if(SODIEHEAL_KIND_BRAIN)
			return !!!banked_brain * SODIEHEAL_RETURN_DEPLETED
		if(SODIEHEAL_KIND_CRIT)
			return FALSE

/obj/item/organ/sodie_organ/proc/squirt_crit()
	if(!owner || QDELETED(owner))
		return FALSE
	if(owner.health > HEALTH_THRESHOLD_FULLCRIT || HAS_TRAIT(owner, TRAIT_NOHARDCRIT))
		return FALSE
	if(avg_tier < SODIE_MIN_TIER_FOR_CRIT)
		return FALSE
	var/has_this_much = 0
	for(var/i in drank)
		has_this_much += drank[i]
	if(has_this_much < SODIE_MIN_AMOUNT_FOR_CRIT)
		return FALSE
	owner.reagents.add_reagent(/datum/reagent/medicine/critmed/brute,            5)
	owner.reagents.add_reagent(/datum/reagent/medicine/critmed/burn,             5)
	owner.reagents.add_reagent(/datum/reagent/medicine/critmed/toxin,            5)
	owner.reagents.add_reagent(/datum/reagent/medicine/critmed/all_damage,       5)
	owner.reagents.add_reagent(/datum/reagent/medicine/critmed/oxy,              5)
	owner.reagents.add_reagent(/datum/reagent/medicine/critmed/radheal,          5)
	owner.reagents.add_reagent(/datum/reagent/medicine/critmed/blood,            5)
	owner.reagents.add_reagent(/datum/reagent/medicine/critmed/blood/stabilizer, 5)
	owner.reagents.add_reagent(/datum/reagent/medicine/critmed/runfast,          10)
	to_chat(owner, span_good("You feel a sudden violent wriggling under your skin, then a rush of adrenaline!"))

/obj/item/organ/sodie_organ/proc/bank_sauce(datum/source, datum/reagent/sodie) // hey, banksauce, michael here
	if(!owner || QDELETED(owner) || !istype(sodie))
		return
	if(sodie.sodie_tier < 1 || sodie.sodie_tier > LAZYLEN(drank))
		return
	if(!sodie.sodie_heal_brute && !sodie.sodie_heal_burn && !sodie.sodie_heal_toxin && !sodie.sodie_heal_brain && !sodie.sodie_heal_oxy)
		return
	var/tier = round(clamp(sodie.sodie_tier, 1, LAZYLEN(drank)))
	var/amount = (sodie.metabolization_rate * (sodie.metabolization_rate / max(min(sodie.metabolization_rate, sodie.volume), 0.001)))
	/// we also need to add the amount of sodie we're processing to the tier
	drank[tier] += amount
	/// check our total sodie drank
	var/total = 0
	for(var/i in 1 to LAZYLEN(drank))
		total += drank[i]
	/// if we're over 300, subtract the amount we just added from all the tiers *except* the one we just added to
	if(total > 300)
		/// may remove more than enough to get us below 300, but that's fine
		var/to_subtract = (CEILING(total - 300, 1) / max(LAZYLEN(drank) - 1, 1))
		for(var/i in 1 to LAZYLEN(drank))
			if(i == tier)
				continue
			drank[i] -= to_subtract
	var/dinorap = 0
	var/count = 0
	for(var/i in 1 to LAZYLEN(drank))
		dinorap += i * drank[i]
		count += drank[i]
	avg_tier = max((dinorap / max(count, 1)), 1)
	var/current_max = SODIEHEAL_MAX_BANK_PER_TIER * avg_tier
	var/ybfffa = 0
	var/prev_banked_brute = banked_brute
	banked_brute = round(min(banked_brute + (sodie.sodie_heal_brute * amount), current_max), 0.01)
	if(COOLDOWN_FINISHED(src, last_brute_max_msg) && prev_banked_brute < current_max && banked_brute >= current_max)
		to_chat(owner, span_good("The aches of daily life dull a bit with that last gulp of sodie."))
		COOLDOWN_START(src, last_brute_max_msg, SODIE_MSG_COOLDOWN)
		ybfffa++
	var/prev_banked_burn = banked_burn
	banked_burn = round(min(banked_burn + (sodie.sodie_heal_burn  * amount), current_max), 0.01)
	if(COOLDOWN_FINISHED(src, last_burn_max_msg) && prev_banked_burn < current_max && banked_burn >= current_max)
		to_chat(owner, span_good("You feel a pleasant chill after that last gulp of sodie."))
		COOLDOWN_START(src, last_burn_max_msg, SODIE_MSG_COOLDOWN)
		ybfffa++ 
	var/prev_banked_tox = banked_tox
	banked_tox = round(min(banked_tox + (sodie.sodie_heal_toxin * amount), current_max), 0.01)
	if(COOLDOWN_FINISHED(src, last_tox_max_msg) && prev_banked_tox < current_max && banked_tox >= current_max)
		to_chat(owner, span_good("The ambient everyday nausea seem to dull a bit after that last gulp of sodie."))
		COOLDOWN_START(src, last_tox_max_msg, SODIE_MSG_COOLDOWN)
		ybfffa++
	var/prev_banked_oxy = banked_oxy
	banked_oxy = round(min(banked_oxy + (sodie.sodie_heal_oxy   * amount), current_max), 0.01)
	if(COOLDOWN_FINISHED(src, last_oxy_max_msg) && prev_banked_oxy < current_max && banked_oxy >= current_max)
		to_chat(owner, span_good("You feel a bit more energetic after that last gulp of sodie."))
		COOLDOWN_START(src, last_oxy_max_msg, SODIE_MSG_COOLDOWN)
		ybfffa++
	var/prev_banked_brain = banked_brain
	banked_brain = round(min(banked_brain + (sodie.sodie_heal_brain * amount), current_max), 0.01)
	if(COOLDOWN_FINISHED(src, last_brain_max_msg) && prev_banked_brain < current_max && banked_brain >= current_max)
		to_chat(owner, span_good("The dull ache in your head seems to dull a bit after that last gulp of sodie."))
		COOLDOWN_START(src, last_brain_max_msg, SODIE_MSG_COOLDOWN)
		ybfffa++ 
	if(ybfffa >= 5)
		to_chat(owner, span_green("Your organ finally feels full again!"))
	return TRUE






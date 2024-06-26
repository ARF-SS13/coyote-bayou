#define PARTIAL_UNUSED FALSE
///
/// HI HELLO WELCOME TO DAN AND BUNNY'S CLEVER CMLS AMMO SPRITE AUTOGENERATION SYSTEM YES
/// Is this you: I ADDED IN A NEW AMMO GUN AND NOW ITS INVISIBLE>?????
/// Invisible your ammo no more, cus we've got a system that'll make sure your ammo is visible and pretty IF you follow the rules!!!
/// Rule 1: ALL AMMO ICONS GO IN /icons/obj/ammo/
///         this is cus we're gonna have one DMI per (visually distinct) ammo type, and we want them all in one place
///         this brings me to...
/// Rule 2: ONE AMMO TYPE PER DMI
///         this is so the automatic sprite compilation system can work its magic without me having to learn *actual* magic
///         trust me you'll thank me later
/// Rule 3: ICON STATES HAVE A RIGID NAMING STRUCTURE THAT MUST BE FOLLOWED
///         the system works off of a system of text identifiers in the sprite names themselves, which define what the sprite is for
///         that's right, the name itself defines if the sprite is an a bullet, a crate, a half-full ammobox, a speedloader with 2/16 bullets, etc
///         the system is as follows:
/// - All box and crate states follow the format "[crate or box]-[when to display it]"
///   - crate-full, box-empty, box-partial, crate-partial-percent-25, etc.
///   - There *must* be a box-full, box-empty, crate-full, and crate-empty state for the system to work
///     - if you don't have these, the system will spam the admins and default to plushies and everyone will laugh
///   - if you have a partial, you have two options: vague partial, or a specific(ish) partial
///     - vague partials are defined with box-partial or crate-partial, and are used to handle cases not handled by more specific partials
///       - It'll be used for any ammo count higher than the highest specific count partial (unless your highest count is equal to the ammo count (though in that case, the full state will be used))
///       - It'll be used for any ammo percentage higher than the highest specific percent partial (unless you have a 100 percent partial)
///       - It'll be used if there are no specific partials set
///       - If there is no vague partial, the system will use the full state instead for ammo values between full and empty
///     - specific partials have two formats: count-# or percent-#
///       - count-# is used for specific(ish) bullet counts, like box-partial-count-5
///       - if you have count partials, and the ammo count does not match any of them, the system will round up to the next highest valid partial
///     - percent-# is used for specific(ish) percentages of ammo in a box or crate, like box-partial-percent-25
///       - if you have percent partials, the system will round the ammo count to a percentage, then find the highest partial that is less than or equal to that percentage
///       - if you have count partials set, those states will be used *if* the ammo count is equal to a valid count state, otherwise it defaults to the percent partials
///       - Be sure to include a 100 percent partial, to handle cases above the highest partial
///         - not required tho, it'll just default to the broad partial if it exists, or the full state otherwise
/// - All bullet states follow the format "bullet-[full or empty]"
///   - bullet-full, bullet-empty, etc.
///   - There *must* be a bullet-full and bullet-empty state for the system to work
/// Rule 4: Have fun! =3
/// Rule 5: I wrote these rules before I finished it, so most of it is wrong, have fun!

//////////////////
/// AMMO KINDS ///
/// ////////// ///
/// Defines the different kinds of functionally identical ammo types to be used by the CMLS system.
/// Defines its name, flavoring, CMLS status, and other largely meaningless properties.
/// Also defines the icon states for the ammo and the box, which are used to visually represent the ammo in the game.
/// so it does both box and bullet! wow!
/datum/ammo_kind
	/// Base name of the ammo kind, used for the name of the ammo, the box, the crate, and the magazine, as well as the projectile
	var/name = "2.22x22mm Sr. Compact"
	/// Flavor text for the casing, used for the desc of the casing
	var/bullet_flavor = "Some kind of bullet, designed in 1925 by Jean-Krousing von de la Krouse III as a way to turn brass into lead. \
		From the moment he laid eyes on the newest creation by Stubby Jack, he knew what he needed to do, and that was create the best \
		way to turn brass into lead. And so, he did. And it was good. And it was called the Gun Bullet."
	/// "You load a 2.22x22mm Sr. Compact round into the chamber."
	var/casing_kind = "round"
	/// "You are hit by a 2.22x22mm Sr. Compact bullet!"
	var/projectile_kind = "bullet"

	/// The name and desc of the associated box
	var/box_name = null // set if you want te box to have a custom name
	var/box_flavor = null // set if you want the box to have a custom flavor

	/// The name and desc of the associated crate
	var/crate_name = null // set if you want te box to have a custom name
	var/crate_flavor = null // set if you want the box to have a custom flavor
	
	/// The name and desc of the associated magazine (if the gun ejects a magazine)
	var/magazine_name = null // set if you want te box to have a custom name
	var/magazine_flavor = null // set if you want the box to have a custom flavor

	/// The caliber to be assigned to the casing, box, magazine, projectile, and, if applicable, the gun
	var/caliber = CALIBER_COMPACT
	/// when we're a box and someone tries to insert a bullet, don't convert it *if* the bullet's ammo_kind type is in this list
	var/list/compatible_kinds = list() // currently doesnt work
	/// the sound properies this bullet makes when fired, when not overwritten by the gun (usually it isnt, but they should be)
	var/sound_properties = CSP_PISTOL_LIGHT // look up [code\modules\projectiles\ammo_casing_gun_sound_properties.dm]
	/// The icon file the auto-cataloguer will use to collect the icon states
	var/ammo_icon = 'icons/obj/ammo/compact.dmi' /// you'll want a separate DMI for each *visually distinct* ammo type

	/// Stuff relating to the damage and such of the bullet
	/// Flat damage is the damage dealt in the abcense of a damage list or range
	var/damage_flat = 0
	/// Damage list is a weighted list of damage values, which is rolled on to determine the damage dealt
	var/list/damage_list = list()
	/// Damage range is a range of damage values, which is rolled on to determine the damage dealt
	var/list/damage_range = list() // list(10, 20) would be 10-20 damage, inclusive, equal distribution
	/// Damage type is the type of damage dealt by the bullet
	var/damage_type = BRUTE // look up [code\__DEFINES\combat.dm] around line 6ish
	/// Damage armor is the armor type the bullet checks against
	var/damage_armor = "bullet" // These arent defines because lol why would they?
	/// how many pellets???
	var/pellet_count = 1 // only used for shotguns
	var/caseless = FALSE // if the bullet is caseless, it will not leave a casing behind

	var/recoil = 4 // how much recoil the gun has when firing this bullet

	/// ammo has a box associated
	var/has_box = TRUE
	/// ammo has a crate associated
	var/has_crate = TRUE
	/// ammo has a bullet associated
	var/has_bullet = TRUE // dunno how any of these would work if set to false, so, uh, dont
	/// ammo has a magazine associated
	var/has_magazine = TRUE

	/// don't touch anything below this line (cus it'll be overwritten!)
	/// dont touch these, they're where the auto-generated icon states will go
	var/list/bullet_states = list()
	var/list/box_states = list()
	var/list/crate_states = list()
	var/list/magazine_states = list()

	/// No overly complicated system would be complete without the application of MAFFS!!!
	/// Autogenerated on world init, whiich is good cus what the fukc is a kurtosis
	var/damage_mean = 0 // the average damage dealt by the bullet
	var/damage_median = 0 // the median damage dealt by the bullet
	var/damage_mode = 0 // the mode damage dealt by the bullet
	var/damage_max = 0 // the maximum damage dealt by the bullet
	var/damage_min = 0 // the minimum damage dealt by the bullet
	var/damage_variance = 0 // the variance of the damage dealt by the bullet
	var/damage_stddev = 0 // the standard deviation of the damage dealt by the bullet
	var/damage_skew = 0 // the skew of the damage dealt by the bullet
	var/damage_kurtosis = 0 // the kurtosis of the damage dealt by the bullet
	var/damage_entropy = 0 // the entropy of the damage dealt by the bullet
	var/damage_critical = 0 // the critical damage dealt by the bullet
	var/damage_critical_chance = 0 // the chance of a critical hit

	/// these are all set by SScmls, dont touch them cus they'll be overwritten
	var/box_max_ammo = 0
	var/crate_max_ammo = 0
	/// these too
	var/box_raw_cost = 0
	var/box_copper_cost = 0
	var/box_silver_cost = 0
	var/box_gold_cost = 0
	/// also these
	var/crate_raw_cost = 0
	var/crate_copper_cost = 0
	var/crate_silver_cost = 0
	var/crate_gold_cost = 0

/datum/ammo_kind/New()
	. = ..()
	CompileStates()
	CalcPrices()
	CatalogueMe()
	CalcSD()
	GenerateTGUI()
	GenerateAmmoTypeDesign()

/datum/ammo_kind/proc/CalcPrices()
	switch(caliber)
		if(CALIBER_COMPACT)
			box_raw_cost = SScmls.compact_ammo_price_per_box
			crate_raw_cost = SScmls.compact_ammo_price_per_crate
			box_max_ammo = SScmls.compact_ammo_per_box
			crate_max_ammo = SScmls.compact_ammo_per_crate
		if(CALIBER_MEDIUM)
			box_raw_cost = SScmls.medium_ammo_price_per_box
			crate_raw_cost = SScmls.medium_ammo_price_per_crate
			box_max_ammo = SScmls.medium_ammo_per_box
			crate_max_ammo = SScmls.medium_ammo_per_crate
		if(CALIBER_LONG)
			box_raw_cost = SScmls.long_ammo_price_per_box
			crate_raw_cost = SScmls.long_ammo_price_per_crate
			box_max_ammo = SScmls.long_ammo_per_box
			crate_max_ammo = SScmls.long_ammo_per_crate
		if(CALIBER_SHOTGUN)
			box_raw_cost = SScmls.shotgun_ammo_price_per_box
			crate_raw_cost = SScmls.shotgun_ammo_price_per_crate
			box_max_ammo = SScmls.shotgun_ammo_per_box
			crate_max_ammo = SScmls.shotgun_ammo_per_crate
	box_gold_cost = round(box_raw_cost / 100)
	box_silver_cost = round((box_raw_cost - (box_gold_cost * 100)) / 10)
	box_copper_cost = round(box_raw_cost - (box_gold_cost * 100) - (box_silver_cost * 10))
	crate_gold_cost = round(crate_raw_cost / 100)
	crate_silver_cost = round((crate_raw_cost - (crate_gold_cost * 100)) / 10)
	crate_copper_cost = round(crate_raw_cost - (crate_gold_cost * 100) - (crate_silver_cost * 10))

/datum/ammo_kind/proc/CalcSD() // oh boy is it gonna tell me im 8.5"x6" again?~
	/// first, determine if we just use flat damage
	if(!LAZYLEN(damage_list) && !LAZYLEN(damage_range))
		/// okay well first, check if we actually have a damage value set
		if(isnull(damage_flat))
			message_admins("No damage values set for [name]!")
			log_world("No damage values set for [name]!")
			CRASH("No damage values set for [name]!")
		damage_mean = damage_flat
		damage_median = damage_flat
		damage_mode = damage_flat
		damage_max = damage_flat
		damage_min = damage_flat
		damage_variance = 0
		damage_stddev = 0
		damage_skew = 0
		damage_kurtosis = 0
		damage_entropy = 0
		return // phew, that was easy
	/// next, determine if we use a damage list, we use this over a range if present
	/// lists have the format list("dmg" = weight, "dmg" = weight, etc.)
	/// so something like list(10 = 1, 20 = 2, 30 = 1) would be a 25% chance of 10, 50% chance of 20, and 25% chance of 30
	if(LAZYLEN(damage_list))
		var/total = 0 // sum of all weights
		var/mean = 0 // mean of the damage
		var/sqmean = 0 // mean of the squares of the damage
		var/variance = 0 // variance of the damage
		var/stddev = 0 // standard deviation of the damage
		var/mode = 0 // the most common damage value
		var/mode_count = 0 // the count of the most common damage value
		var/entropy = 0 // the entropy of the damage list
		var/dmg_min = 0 // the smallest damage value
		var/dmg_max = 0 // the largest damage value
		for(var/dam in damage_list)
			var/dmg = text2num(dam)
			var/weight = damage_list[dam]
			total += weight
			mean += dmg * weight
			sqmean += dmg * dmg * weight
			if(weight > mode_count)
				mode_count = weight
				mode = dmg
			if(!dmg_min || dmg < dmg_min)
				dmg_min = dmg
			if(!dmg_max || dmg > dmg_max)
				dmg_max = dmg
		mean /= total
		sqmean /= total
		variance = sqmean - (mean * mean)
		stddev = sqrt(variance)
		/// calculate the entropy
		for(var/dam in damage_list)
			var/weight = damage_list[dam]
			entropy += -1 * (weight / total) * log(1 * (weight / total))
		entropy /= log(2) // convert to base 2
		/// calculate the skew
		var/skew = 0
		for(var/dam in damage_list)
			var/dmg = text2num(dam)
			var/weight = damage_list[dam]
			skew += ((dmg - mean) * (dmg - mean) * (dmg - mean)) * weight
		skew /= (total * stddev * stddev * stddev)
		/// calculate the kurtosis
		var/kurtosis = 0 // idk what kurtosis is but copilot seems to and its definitely smarter than me
		for(var/dam in damage_list)
			var/dmg = text2num(dam)
			var/weight = damage_list[dam]
			kurtosis += ((dmg - mean) * (dmg - mean) * (dmg - mean) * (dmg - mean)) * weight
		kurtosis /= (total * stddev * stddev * stddev * stddev)
		/// set the values
		damage_mean = mean
		damage_median = mode
		damage_mode = mode
		damage_max = dmg_max
		damage_min = dmg_min
		damage_variance = variance
		damage_stddev = stddev
		damage_skew = skew
		damage_kurtosis = kurtosis
		damage_entropy = entropy
		/// now check if the highest number in the damage list is significantly higher than the mean
		/// if so, this will be our critical damage, otherwise there's no critical damage
		if(dmg_max > (mean + (stddev * 1.2)))
			damage_critical = dmg_max
			/// our damage list is weighted, so we need to calculate the chance of picking the highest value
			damage_critical_chance = (damage_list["[dmg_max]"] / total) * 100
			// then, set the max damage to the number that is in the damage list just below the max
			// this is so we dont have the readout say it does 20-9000 damage when it just crits for 9000 and does 20-80 normally
			var/highest = 0
			var/second_highest = 0
			for(var/dam in damage_list)
				var/dmg = text2num(dam)
				if(dmg > highest)
					second_highest = highest
					highest = dmg
			damage_max = second_highest
		return
	/// finally, determine if we use a damage range
	if(LAZYLEN(damage_range))
		if(LAZYLEN(damage_range) < 2) // normalize for busted ranges
			var/list/newlist = list(damage_range[1], damage_range[1])
			damage_range = newlist
		if(LAZYLEN(damage_range) > 2) // normalize for busted ranges
			var/list/newlist = list()
			var/hiest = 0
			var/loest = 0
			for(var/dmg in damage_range)
				if(!loest || dmg < loest)
					loest = dmg
				if(!hiest || dmg > hiest)
					hiest = dmg
			newlist += loest
			newlist += hiest
			damage_range = newlist
		var/variance = 0
		var/stddev = 0
		var/entropy = 0
		var/skew = 0
		var/kurtosis = 0
		var/mean = (damage_range[1] + damage_range[2]) / 2
		var/sqmean = (damage_range[1] * damage_range[1] + damage_range[2] * damage_range[2]) / 2
		variance = sqmean - (mean * mean)
		stddev = sqrt(variance)
		/// calculate the entropy
		entropy = -1 * (0.5 * log(0.5) + 0.5 * log(0.5)) / log(2)
		/// calculate the skew
		skew = 0
		for(var/dmg in damage_range)
			skew += ((dmg - mean) * (dmg - mean) * (dmg - mean))
		skew /= (2 * stddev * stddev * stddev)
		/// calculate the kurtosis
		kurtosis = 0
		for(var/dmg in damage_range)
			kurtosis += ((dmg - mean) * (dmg - mean) * (dmg - mean) * (dmg - mean))
		kurtosis /= (2 * stddev * stddev * stddev * stddev)
		/// set the values
		damage_mean = mean
		damage_median = mean
		damage_mode = mean
		damage_max = max(damage_range[1], damage_range[2])
		damage_min = min(damage_range[1], damage_range[2])
		damage_variance = variance
		damage_stddev = stddev
		damage_skew = skew
		damage_kurtosis = kurtosis
		damage_entropy = entropy
		return // good enough
	/// if we get here, something went wrong
	message_admins("No damage values set for [name]!")
	log_world("No damage values set for [name]!")
	CRASH("No damage values set for [name]!")

/datum/ammo_kind/proc/CatalogueMe()
	SScmls.ammos[type] = src
	switch(caliber)
		if(CALIBER_COMPACT)
			if(has_bullet)
				SScmls.all_C_bullet[type] = src
			if(has_box)
				SScmls.all_C_box[type] = src
			if(has_crate)
				SScmls.all_C_crate[type] = src
		if(CALIBER_MEDIUM)
			if(has_bullet)
				SScmls.all_M_bullet[type] = src
			if(has_box)
				SScmls.all_M_box[type] = src
			if(has_crate)
				SScmls.all_M_crate[type] = src
		if(CALIBER_LONG)
			if(has_bullet)
				SScmls.all_L_bullet[type] = src
			if(has_box)
				SScmls.all_L_box[type] = src
			if(has_crate)
				SScmls.all_L_crate[type] = src
		if(CALIBER_SHOTGUN)
			if(has_bullet)
				SScmls.all_S_bullet[type] = src
			if(has_box)
				SScmls.all_S_box[type] = src
			if(has_crate)
				SScmls.all_S_crate[type] = src

/datum/ammo_kind/proc/StoreState(CorB, suffix, partial, key, state)
	var/list/statebox
	CorB = SScmls.ExtractCORB(CorB)
	switch(CorB)
		if(CORB_BULLET)
			statebox = bullet_states
		if(CORB_BOX)
			statebox = box_states
		if(CORB_CRATE)
			statebox = crate_states
		if(CORB_MAGAZINE)
			statebox = magazine_states
	var/suffpart = "[suffix]"
	if(partial)
		suffpart = "[suffpart]-[partial]"
	var/datum/ammo_istate_holder/holder = LAZYACCESS(statebox, suffpart)
	if(!holder)
		holder = new /datum/ammo_istate_holder(!key) // no key means we only want one state
		statebox[suffpart] = holder
	holder.AddState(state, key)
	switch(CorB)
		if(CORB_BULLET)
			bullet_states = statebox
		if(CORB_BOX)
			box_states = statebox
		if(CORB_CRATE)
			crate_states = statebox
		if(CORB_MAGAZINE)
			magazine_states = statebox
	holder.Sortify()

/datum/ammo_kind/proc/GetState(CorB, suffix, partial, key)
	var/list/statebox
	CorB = SScmls.ExtractCORB(CorB)
	switch(CorB)
		if(CORB_BULLET)
			statebox = bullet_states
		if(CORB_BOX)
			statebox = box_states
		if(CORB_CRATE)
			statebox = crate_states
		if(CORB_MAGAZINE)
			statebox = magazine_states
	var/suffpart = "[suffix]"
	if(partial)
		suffpart = "[suffpart]-[partial]"
	var/datum/ammo_istate_holder/holder = LAZYACCESS(statebox, suffpart)
	if(!holder)
		return PARTIAL_UNUSED
	return holder.GetState(key)

/datum/ammo_kind/proc/UsesPartial(CorB, partial)
	var/list/statebox
	switch(CorB)
		if(CORB_BULLET)
			statebox = bullet_states
		if(CORB_BOX)
			statebox = box_states
		if(CORB_CRATE)
			statebox = crate_states
		if(CORB_MAGAZINE)
			statebox = magazine_states
	var/partiate = "[SUFFIX_PARTIAL]-[partial]"
	var/datum/ammo_istate_holder/holder = LAZYACCESS(statebox, partiate)
	if(!holder)
		return FALSE
	return TRUE

/datum/ammo_kind/proc/GetLowestStateGreaterThanInput(CorB, partial, keyin)
	var/list/statebox
	CorB = SScmls.ExtractCORB(CorB)
	switch(CorB)
		if(CORB_BULLET)
			CRASH("Bullet partials are not supported!")
		if(CORB_BOX)
			statebox = box_states
		if(CORB_CRATE)
			statebox = crate_states
		if(CORB_MAGAZINE)
			statebox = magazine_states
	var/partate = "[SUFFIX_PARTIAL]-[partial]"
	var/datum/ammo_istate_holder/holder = LAZYACCESS(statebox, partate)
	if(!holder)
		return PARTIAL_UNUSED
	return holder.GetLowestGreaterThanInput("[keyin]")


/// reads our DMI and compiles a list of states for the icon
/datum/ammo_kind/proc/CompileStates()
	var/list/my_states = icon_states(ammo_icon)
	/// plushie error if the icon is valid (game wont compile if the icon doesnt exist), or it lacks the mandatory states (full and empty)
	if(FailState(my_states)) // you fail the state game (Montanafornia isnt a state)
		ammo_icon = 'icons/obj/plushes.dmi'
		StoreState(CORB_BULLET,     SUFFIX_FULL,    null,        null, "hairball")
		StoreState(CORB_BULLET,     SUFFIX_EMPTY,   null,        null, "fermis"  )
		StoreState(CORB_BULLET,     SUFFIX_PROJ,    null,        null, "fermis"  )
		StoreState(CORB_BOX,        SUFFIX_FULL,    null,        null, "kobold"  )
		StoreState(CORB_BOX,        SUFFIX_EMPTY,   null,        null, "fox"     )
		StoreState(CORB_BOX,        SUFFIX_PARTIAL, PART_BROAD,  null, "fox"     )
		StoreState(CORB_CRATE,      SUFFIX_FULL,    null,        null, "bird"    )
		StoreState(CORB_CRATE,      SUFFIX_EMPTY,   null,        null, "sergal"  )
		StoreState(CORB_CRATE,      SUFFIX_PARTIAL, PART_BROAD,  null, "sergal"  )
		StoreState(CORB_MAGAZINE,   SUFFIX_FULL,    null,        null, "hairball")
		StoreState(CORB_MAGAZINE,   SUFFIX_EMPTY,   null,        null, "hairball")
		StoreState(CORB_MAGAZINE,   SUFFIX_PARTIAL, PART_BROAD,  null, "hairball")
		// default to plushes if we can't find the icon
		message_admins("No states found for [name]!")
		CRASH("No states found for [name]!")

	/// just to flex my dikc about how many codersprites we have
	/// these all need to have had the right names, or all is lost
	if(has_bullet)
		StoreState(CORB_BULLET, SUFFIX_FULL,  null, null, BULLET_FULL_STATE )
		StoreState(CORB_BULLET, SUFFIX_EMPTY, null, null, BULLET_EMPTY_STATE)
		StoreState(CORB_BULLET, SUFFIX_PROJ,  null, null, BULLET_PROJ_STATE )
	if(has_box)
		StoreState(CORB_BOX,   SUFFIX_FULL,  null, null, BOX_FULL_STATE     )
		StoreState(CORB_BOX,   SUFFIX_EMPTY, null, null, BOX_EMPTY_STATE    )
	if(has_crate) 
		StoreState(CORB_CRATE, SUFFIX_FULL,  null, null, CRATE_FULL_STATE   )
		StoreState(CORB_CRATE, SUFFIX_EMPTY, null, null, CRATE_EMPTY_STATE  )
	if(has_magazine)
		StoreState(CORB_MAGAZINE, SUFFIX_FULL,  null, null, MAGAZINE_FULL_STATE )
		StoreState(CORB_MAGAZINE, SUFFIX_EMPTY, null, null, MAGAZINE_EMPTY_STATE)


	/// Now check for extra partials and add them to the list
	/// ANATOMY OF A PARTIAL: [CORB]-[PARTIAL-or-magazine-suffix]-[COUNT OR PERCENT]-[NUMBER]
	for(var/istate in my_states)
		var/list/partial_breakup = splittext(istate, "-")
		if(LAZYACCESS(partial_breakup, 2) != SUFFIX_PARTIAL)
			continue
		var/CorB = SScmls.ExtractCORB(LAZYACCESS(partial_breakup, 1))
		if(!LAZYACCESS(partial_breakup, 3)) // it was a broad partial
			StoreState(CorB, SUFFIX_PARTIAL, PART_BROAD, null, istate)
			continue
		// a specific partial! maybe. first entry should be count or percent, the second a number
		/// strip out any non-numaerical characters from the second entry
		var/onum = LAZYACCESS(partial_breakup, 4) // "box-partial-something-number"
		var/nunum = ""
		for(var/i in 1 to LAZYLEN(onum))
			var/letr = onum[i]
			if(letr in list("0","1","2","3","4","5","6","7","8","9")) // brilliant
				nunum = "[nunum][letr]"
		if(!nunum)
			continue
		/// now we have a number, we can check if it's a count or a percent
		if(partial_breakup[3] == PART_COUNT)
			StoreState(CorB, SUFFIX_PARTIAL, PART_COUNT, "[nunum]", istate)
			continue
		if(partial_breakup[3] == PART_PERCENT)
			StoreState(CorB, SUFFIX_PARTIAL, PART_PERCENT, "[nunum]", istate)
			continue

/datum/ammo_kind/proc/FailState(states)
	if(!LAZYLEN(states))
		return TRUE
	if(has_bullet)
		if(!("[BULLET_FULL_STATE]" in states))
			return TRUE
		if(!("[BULLET_EMPTY_STATE]" in states))
			return TRUE
		if(!("[BULLET_PROJ_STATE]" in states))
			return TRUE
	if(has_box)
		if(!("[BOX_FULL_STATE]" in states))
			return TRUE
		if(!("[BOX_EMPTY_STATE]" in states))
			return TRUE
	if(has_crate)
		if(!("[CRATE_FULL_STATE]" in states))
			return TRUE
		if(!("[CRATE_EMPTY_STATE]" in states))
			return TRUE
	if(!has_bullet && !has_box && !has_crate) // then what're you doing here!!!
		return TRUE
	return FALSE

/datum/ammo_kind/proc/CrudeInsertionSort(list/countstates)
	if(!LAZYLEN(countstates))
		return list()
	var/list/ordered = list()
	ordered.len = LAZYLEN(countstates)
	var/i = 1
	var/safety_counter = 100
	while(LAZYLEN(countstates) && safety_counter--)
		var/lowest = null
		for(var/istate in countstates)
			var/ttn = text2num(istate)
			if(!lowest) // THATS RIGHT WE USING INSERTION SORT BAYBEE
				lowest = text2num(istate)
			if(ttn < lowest)
				lowest = ttn
		if(lowest == null)
			break // just error, idfk
		ordered[i] = countstates["[lowest]"]
		countstates -= ordered[i]
		i++
	return ordered

/// converts A and B from text to numbers, then returns a Tim sort friendly comparison that'll sort from smallest at the top to biggest at the bottom

/// full overwrite of the bullet with our bullet data
/// Will change caliber! Be careful!
/datum/ammo_kind/proc/AKSetupBullet(obj/item/ammo_casing/generic/AC)
	if(!istype(AC))
		return
	AC.ammo_kind = type
	AC.caliber = caliber
	AC.sound_properties = sound_properties
	AC.pellets = pellet_count
	AKSetupProjectile(AC.BB)
	AKSkinBullet(AC)

/// Sets the actual functional properties of the bullet, like the damage, armor type, and damage type
/datum/ammo_kind/proc/AKSetupProjectile(obj/item/projectile/BB)
	if(!istype(BB))
		return
	BB.damage = damage_mean
	BB.damage_type = damage_type
	BB.flag = damage_armor // dunno why its flag on the projectile
	BB.damage_list = damage_list
	BB.damage_low = damage_min
	BB.damage_high = damage_max
	BB.name = GetBulletProjectileName(BB)
	BB.icon = GetBulletIcon()
	BB.icon_state = GetBulletProjectileIconState(BB)
	BB.recoil = recoil
	BB.desc = "If you can read this, you're too close!"

/datum/ammo_kind/proc/ShouldConvertBullet(obj/item/ammo_casing/generic/AC)
	if(!istype(AC))
		return FALSE
	if(!LAZYLEN(compatible_kinds))
		return TRUE
	for(var/ammokind in compatible_kinds)
		if(ammokind == AC.ammo_kind)
			return FALSE
	return TRUE

/// Sets the non-functional properties of the bullet, like the name, flavor, and icon state
/datum/ammo_kind/proc/AKSkinBullet(obj/item/ammo_casing/generic/AC, soft)
	if(!istype(AC))
		return
	if(soft)
		if(!ShouldConvertBullet(AC))
			return
	AC.ammo_kind = type
	AC.name = GetBulletName(AC)
	AC.desc = GetBulletFlavor(AC)
	AC.icon = GetBulletIcon()
	AC.icon_state = GetBulletIconState(AC)

/// Updates the bullet's icon state
/datum/ammo_kind/proc/AKUpdateBullet(obj/item/ammo_casing/generic/AC)
	if(!istype(AC))
		return
	AC.icon_state = GetBulletIconState(AC)

/// full overwrite of the box with our box data, including ammo count, max, etc
/datum/ammo_kind/proc/AKSetupBox(obj/item/ammo_box/generic/mag, CorB = CORB_BOX, obj/item/gun/ballistic/gunthing)
	if(!istype(mag))
		return
	mag.box_CorB = SScmls.ExtractCORB(CorB || mag.box_CorB)
	mag.ammo_kind = type
	mag.caliber = list(caliber)
	switch(caliber)
		if(CALIBER_COMPACT)
			switch(CorB)
				if(CORB_BOX)
					mag.max_ammo = SScmls.compact_ammo_per_box
				if(CORB_CRATE)
					mag.max_ammo = SScmls.compact_ammo_per_crate
				if(CORB_MAGAZINE)
					mag.max_ammo = 1
		if(CALIBER_MEDIUM)
			switch(CorB)
				if(CORB_BOX)
					mag.max_ammo = SScmls.medium_ammo_per_box
				if(CORB_CRATE)
					mag.max_ammo = SScmls.medium_ammo_per_crate
				if(CORB_MAGAZINE)
					mag.max_ammo = 1
		if(CALIBER_LONG)
			switch(CorB)
				if(CORB_BOX)
					mag.max_ammo = SScmls.long_ammo_per_box
				if(CORB_CRATE)
					mag.max_ammo = SScmls.long_ammo_per_crate
				if(CORB_MAGAZINE)
					mag.max_ammo = 1
		if(CALIBER_SHOTGUN)
			switch(CorB)
				if(CORB_BOX)
					mag.max_ammo = SScmls.shotgun_ammo_per_box
				if(CORB_CRATE)
					mag.max_ammo = SScmls.shotgun_ammo_per_crate
				if(CORB_MAGAZINE)
					mag.max_ammo = 1
	AKSkinBox(mag, TRUE) // just in case its fulla ammos
	mag.start_empty = FALSE
	if(istype(gunthing))
		mag.PrepForGun(gunthing)
	mag.init_ammo()
	AKUpdateBox(mag)

/// full overwrite of the box with our box data, including ammo count, max, etc
/datum/ammo_kind/proc/AKSetupMagazine(obj/item/ammo_box/generic/magazine/mag, obj/item/ammo_box/generic/source)
	if(!istype(mag) || !istype(source))
		return
	mag.MagazineifyFrom(source)
	mag.LoadFromSource(source)
	AKSkinBox(mag, TRUE) // just in case its fulla ammos
	AKUpdateBox(mag)

/// Sets the non-functional properties of the box, like the name, flavor, and icon state
/datum/ammo_kind/proc/AKSkinBox(obj/item/ammo_box/generic/mag, bullets_too)
	if(!istype(mag))
		return
	var/CorB = SScmls.ExtractCORB(mag.box_CorB)
	mag.ammo_kind = type
	switch(CorB)
		if(CORB_BULLET)
			return
		if(CORB_BOX)
			mag.name = GetBoxName(mag)
			mag.desc = GetBoxFlavor(mag)
		if(CORB_CRATE)
			mag.name = GetCrateName(mag)
			mag.desc = GetCrateFlavor(mag)
		if(CORB_MAGAZINE)
			mag.name = GetMagazineName(mag)
			mag.desc = GetMagazineFlavor(mag)
	mag.icon = GetBoxIcon()
	mag.icon_state = GetBoxIconState(mag)
	if(bullets_too)
		for(var/obj/item/ammo_casing/generic/AC in mag.contents)
			AKSkinBullet(AC, TRUE)

/// Updates the box's icon state
/datum/ammo_kind/proc/AKUpdateBox(obj/item/ammo_box/generic/mag)
	if(!istype(mag))
		return
	mag.icon_state = GetBoxIconState(mag)

/// generates some guff for TGUI, for the vendor thing that totally exists
/// actually makes two, one for a box, one for a crate
/datum/ammo_kind/proc/GenerateTGUI()
	var/list/dat = list()
	/// first, the box
	var/cmls
	var/C_M_L_S = "???"
	var/rawcost = 0
	var/coppercost = 0
	var/silvercost = 0
	var/goldcost = 0
	var/dam_flat = !LAZYLEN(damage_list) && !LAZYLEN(damage_range) ? damage_flat : "X"
	var/dam_min = round(damage_min, 0.1)
	var/dam_max = round(damage_max, 0.1)
	var/dam_mean = round(damage_mean, 0.1)
	var/dam_median = round(damage_median, 0.1)
	var/dam_mode = round(damage_mode, 0.1)
	var/dam_variance = round(damage_variance, 0.1)
	var/dam_stddev = round(damage_stddev, 0.1)
	var/dam_skew = round(damage_skew, 0.1)
	var/dam_kurtosis = round(damage_kurtosis, 0.1)
	var/dam_entropy = round(damage_entropy, 0.1)
	var/dam_crit = damage_critical ? damage_critical : "X"
	var/dam_crit_chance = damage_critical_chance ? round(damage_critical_chance, 0.1) : "X"
	var/shorteneddesc = bullet_flavor
	/// okay check if the highest damage value is significantly higher than the mean
	/// we'll call that the crit value
	if(LAZYLEN(shorteneddesc) > 100)
		shorteneddesc = copytext(shorteneddesc, 1, 97) + "..."
	if(has_box)
		dat = list()
		rawcost = SScmls.compact_ammo_price_per_box
		switch(caliber)
			if(CALIBER_COMPACT)
				cmls = "Compact Ammo Boxes"
				C_M_L_S = "C"
			if(CALIBER_MEDIUM)
				cmls = "Medium Ammo Boxes"
				C_M_L_S = "M"
			if(CALIBER_LONG)
				cmls = "Long Ammo Boxes"
				C_M_L_S = "L"
			if(CALIBER_SHOTGUN)
				cmls = "Shotgun Ammo Boxes"
				C_M_L_S = "S"
		goldcost = round(rawcost / 100)
		silvercost = round((rawcost - (goldcost * 100)) / 10)
		coppercost = round(rawcost - (goldcost * 100) - (silvercost * 10))
		dat["Category"] = cmls
		dat["Name"] = "[name] Box ([C_M_L_S])"
		dat["Crate"] = FALSE
		dat["MaxAmmo"] = box_max_ammo
		dat["Desc"] = bullet_flavor
		dat["ShortDesc"] = shorteneddesc
		dat["RawCost"] = rawcost
		dat["CopperCost"] = coppercost
		dat["SilverCost"] = silvercost
		dat["GoldCost"] = goldcost
		dat["C_M_L_S"] = C_M_L_S
		dat["Caliber"] = caliber
		dat["KindPath"] = "[type]"
		dat["IsBox"] = TRUE
		dat["IsCrate"] = FALSE
		dat["DamageFlat"] = dam_flat
		dat["DamageMin"] = dam_min
		dat["DamageMax"] = dam_max
		dat["DamageMean"] = dam_mean
		dat["DamageMedian"] = dam_median
		dat["DamageMode"] = dam_mode
		dat["DamageVariance"] = dam_variance
		dat["DamageStdDev"] = dam_stddev
		dat["DamageSkew"] = dam_skew
		dat["DamageKurtosis"] = dam_kurtosis
		dat["DamageEntropy"] = dam_entropy
		dat["DamageCrit"] = dam_crit
		dat["DamageCritChance"] = dam_crit_chance
		SScmls.data_for_tgui += list(dat)
	/// then, the crate
	if(has_crate)
		dat = list()
		rawcost = SScmls.compact_ammo_price_per_crate
		coppercost = 0
		silvercost = 0
		goldcost = 0
		switch(caliber)
			if(CALIBER_COMPACT)
				cmls = "Compact Ammo Crates"
			if(CALIBER_MEDIUM)
				cmls = "Medium Ammo Crates"
			if(CALIBER_LONG)
				cmls = "Long Ammo Crates"
			if(CALIBER_SHOTGUN)
				cmls = "Shotgun Ammo Crates"
		goldcost = round(rawcost / 100)
		silvercost = round((rawcost - (goldcost * 100)) / 10)
		coppercost = round(rawcost - (goldcost * 100) - (silvercost * 10))
		dat["Category"] = cmls
		dat["Name"] = "[name] Crate ([C_M_L_S])"
		dat["Desc"] = bullet_flavor
		dat["Crate"] = TRUE
		dat["MaxAmmo"] = crate_max_ammo
		shorteneddesc = bullet_flavor
		if(LAZYLEN(shorteneddesc) > 100)
			shorteneddesc = copytext(shorteneddesc, 1, 97) + "..."
		dat["ShortDesc"] = shorteneddesc
		dat["RawCost"] = rawcost
		dat["CopperCost"] = coppercost
		dat["SilverCost"] = silvercost
		dat["GoldCost"] = goldcost
		dat["C_M_L_S"] = C_M_L_S
		dat["Caliber"] = caliber
		dat["KindPath"] = "[type]"
		dat["IsBox"] = FALSE
		dat["IsCrate"] = TRUE
		dat["DamageFlat"] = dam_flat
		dat["DamageMin"] = dam_min
		dat["DamageMax"] = dam_max
		dat["DamageMean"] = dam_mean
		dat["DamageMedian"] = dam_median
		dat["DamageMode"] = dam_mode
		dat["DamageVariance"] = dam_variance
		dat["DamageStdDev"] = dam_stddev
		dat["DamageSkew"] = dam_skew
		dat["DamageKurtosis"] = dam_kurtosis
		dat["DamageEntropy"] = dam_entropy
		dat["DamageCrit"] = dam_crit
		dat["DamageCritChance"] = dam_crit_chance
		SScmls.data_for_tgui += list(dat)


/// For the lathe to build our ammo without having to make a million other datums, PAUL
/// generates boxes! It's a box generator!
/datum/ammo_kind/proc/GenerateAmmoTypeDesign()
	var/C_or_M_or_L_or_S = "???"
	var/compactorsuch = "???"
	switch(caliber)
		if(CALIBER_COMPACT)
			C_or_M_or_L_or_S = "C"
			compactorsuch = "Compact Ammo"
		if(CALIBER_MEDIUM)
			C_or_M_or_L_or_S = "M"
			compactorsuch = "Medium Ammo"
		if(CALIBER_LONG)
			C_or_M_or_L_or_S = "L"
			compactorsuch = "Long Ammo"
		if(CALIBER_SHOTGUN)
			C_or_M_or_L_or_S = "S"
			compactorsuch = "Shotgun Ammo"
	if(has_box)
		var/datum/design/ammolathe/amo = new()
		amo.name = "[GetBoxName()] ([C_or_M_or_L_or_S])"
		amo.id = ckey("[type]_[C_or_M_or_L_or_S]")
		amo.build_path = /obj/item/ammo_box/generic
		var/catbox = "[compactorsuch] Box"
		SScmls.design_cats |= catbox
		amo.box_CorB = CORB_BOX
		amo.category = list("initial", "[catbox]")
		amo.ammotype = type
	/// and a crate
	if(has_crate)
		var/datum/design/ammolathe/amo_crate = new()
		amo_crate.name = "[GetCrateName()] ([C_or_M_or_L_or_S])"
		amo_crate.id = ckey("[type]_[C_or_M_or_L_or_S]_crate")
		amo_crate.build_path = /obj/item/ammo_box/generic/crate
		var/catcrate = "[compactorsuch] Crate"
		SScmls.design_cats |= catcrate
		amo_crate.box_CorB = CORB_CRATE
		amo_crate.category = list("initial", "[catcrate]")
		amo_crate.ammotype = type



/datum/ammo_kind/proc/GetBulletIcon()
	return ammo_icon

/datum/ammo_kind/proc/GetBulletName(obj/item/ammo_casing/AC)
	if(!AC)
		return "[name] [casing_kind]"
	if(!AC.BB)
		return "Spent [name] [casing_kind]"
	return "[name] [casing_kind]"

/datum/ammo_kind/proc/GetBulletFlavor(obj/item/ammo_casing/AC)
	if(!AC)
		return "Probably a bullet? Not sure"
	var/list/desclines = list()
	if(bullet_flavor)
		desclines += bullet_flavor
	else
		desclines += "This is some kind of bullet. It's probably dangerous if you put it into something that shoots it. Speaking of..."
	desclines += span_notice("This is a <u>[span_green("[capitalize("[caliber]")]")]</u>! It'll fit in any gun or box that can hold <u>[span_green("[capitalize("[caliber]")]")]</u>!")
	return desclines.Join("<br>")

/datum/ammo_kind/proc/GetBulletProjectileName(obj/item/projectile/AC)
	return "[name] [projectile_kind]"

/datum/ammo_kind/proc/GetBulletProjectileIconState(obj/item/projectile/AC)
	return GetState(CORB_BULLET, SUFFIX_PROJ,  null, null)

/datum/ammo_kind/proc/GetBulletIconState(obj/item/ammo_casing/AC)
	if(!has_bullet)
		CRASH("BULLET STATE REQUESTED FOR [name] BUT NO BULLET STATES DEFINED! might want to fix that")
	if(!AC || !AC.BB)
		return GetState(CORB_BULLET, SUFFIX_EMPTY, null, null)
	return     GetState(CORB_BULLET, SUFFIX_FULL,  null, null)

/datum/ammo_kind/proc/GetBoxName(obj/item/ammo_box/generic/mag)
	if(mag?.rawname)
		return mag.rawname
	if(box_name)
		return box_name
	return "[name] box"

/datum/ammo_kind/proc/GetCrateName(obj/item/ammo_box/generic/mag)
	if(crate_name)
		return crate_name
	return "[name] crate"

/datum/ammo_kind/proc/GetCrateFlavor(obj/item/ammo_box/generic/mag)
	if(!mag)
		return "A crate of ammo. It's a box, and it supposedly holds ammo. Neat!"
	var/list/desclines = list()
	if(crate_flavor)
		desclines += crate_flavor
	else
		desclines += "This is some kind of crate that's supposed to hold ammo. It's pretty big, able to hold a lot more bullets than a box. Speaking of..."
	desclines += span_notice("This is a <u>[span_green("[capitalize("[caliber]")]")]</u> crate! It'll hold any <u>[span_green("[capitalize("[caliber]")]")]</u> ammo!")
	return desclines.Join("<br>")

/datum/ammo_kind/proc/GetBoxFlavor(obj/item/ammo_box/generic/mag)
	if(!mag)
		return "A box of ammo. It's a box, and it supposedly holds ammo. Neat!"
	var/list/desclines = list()
	if(box_flavor)
		desclines += box_flavor
	else
		desclines += "This is some kind of box that's supposed to hold ammo. It's pretty small, able to hold a few bullets. Speaking of..."
	desclines += span_notice("This is a <u>[span_green("[capitalize("[caliber]")]")]</u> box! It'll hold any <u>[span_green("[capitalize("[caliber]")]")]</u> ammo!")
	return desclines.Join("<br>")

/datum/ammo_kind/proc/GetMagazineName(obj/item/ammo_box/generic/mag)
	if(magazine_name)
		return magazine_name
	return "[name] magazine"

/datum/ammo_kind/proc/GetMagazineFlavor(obj/item/ammo_box/generic/mag)
	if(!mag)
		return "A magazine of ammo. It's a box, and it supposedly holds ammo. Neat!"
	var/list/desclines = list()
	if(magazine_flavor)
		desclines += magazine_flavor
	else
		desclines += "This is some kind of magazine that's supposed to hold ammo. It's pretty small, able to hold a few bullets. Speaking of..."
	desclines += span_notice("This is a <u>[span_green("[capitalize("[caliber]")]")]</u> magazine! It'll hold any <u>[span_green("[capitalize("[caliber]")]")]</u> ammo!")
	return desclines.Join("<br>")

/datum/ammo_kind/proc/GetBoxIcon()
	return ammo_icon

/datum/ammo_kind/proc/GetBoxIconState(obj/item/ammo_box/generic/mag, box_or_crate_override)
	if(!mag)
		return GetState(CORB_BOX, SUFFIX_EMPTY, null, null) || GetState(CORB_CRATE, SUFFIX_EMPTY, null, null)
	var/mag_size = mag.max_ammo
	var/mag_loaded = mag.ammo_count(TRUE) // also get empties for revolvers (not that it matters)
	var/CB = SScmls.ExtractCORB(box_or_crate_override || mag.box_CorB || CORB_BOX)
	/// first, check if we are full!
	if(mag_loaded >= mag_size)
		return GetState(CB, SUFFIX_FULL, null, null )
	/// then, check if we are empty!
	if(mag_loaded < 1)
		return GetState(CB, SUFFIX_EMPTY, null, null)
	/// finally, we are partial! We'll default to the broad partial, or "Full" if there is no broad partial, if there isnt a valid partial
	/// first check if we have a specific match in the specifics
	if(UsesPartial(CB, PART_COUNT))
		var/countstat = GetState(CB, SUFFIX_PARTIAL, PART_COUNT, "[mag_loaded]") // shoot in the dark and see if we have a count partial that matches our ammo count
		if(countstat)
			return countstat
		var/vaguetry = GetLowestStateGreaterThanInput(CB, PART_COUNT, "[mag_loaded]")
		if(vaguetry)
			return vaguetry
	// if not, check the percentages
	if(UsesPartial(CB, PART_PERCENT))
		var/percent = round((mag_loaded / mag_size) * 100)
		if(percent > 100) // we can't have more than 100% ammo, so if we do
			percent = 100
		var/exactstate = GetState(CB, SUFFIX_PARTIAL, PART_PERCENT, "[percent]")
		if(exactstate)
			return exactstate
		var/vaguetry = GetLowestStateGreaterThanInput(CB, PART_PERCENT, "[percent]")
		if(vaguetry)
			return vaguetry
	return GetState(CB, SUFFIX_PARTIAL, PART_BROAD, null) || GetState(CB, SUFFIX_FULL, null, null) // default to full if we don't have a broad partial










///////////////////////////AMMO KINDS///////////////////////////
/datum/ammo_istate_holder
	var/list/states = list()
	var/one_state = null

/datum/ammo_istate_holder/proc/AddState(state, key)
	if(!key)
		one_state = state
	else
		states[key] = state
	SScmls.num_ammo_states++

/datum/ammo_istate_holder/proc/GetState(key)
	if(one_state)
		return one_state // BABYALIEN ONEARTH
	if(!LAZYLEN(states)) // nothing stored, perfectly valid, return PARTIAL_UNUSED
		return PARTIAL_UNUSED
	return LAZYACCESS(states, key)

/// compares the input with our list of (hopefully) numbers
/// any key in our list that is a number greater than the input is stored
/// if more than one key is stored, the lowest key is returned
/// Basically it's looking for a key that is the lowest number greater than the input
/datum/ammo_istate_holder/proc/GetLowestGreaterThanInput(txtcount)
	if(one_state)
		return one_state // BABYALIEN ONEARTH
	if(!LAZYLEN(states)) // nothing stored, perfectly valid, return PARTIAL_UNUSED
		return PARTIAL_UNUSED
	var/count = text2num(txtcount)
	var/lowesthigher = null
	for(var/key in states)
		var/numkey = text2num(key)
		if(numkey > count)
			if(!lowesthigher || numkey < lowesthigher)
				lowesthigher = numkey
	if(!isnull(lowesthigher))
		return LAZYACCESS(states, "[lowesthigher]")
	return FALSE

/datum/ammo_istate_holder/proc/Sortify()
	states = sort_list(states, /proc/cmp_text2num)

/proc/cmp_text2num(A, B)
	return text2num(A) - text2num(B)





/obj/item/storage/belt
	name = "belt"
	desc = "Can hold various things."
	icon = 'icons/obj/clothing/belts.dmi'
	icon_state = "utilitybelt"
	inhand_icon_state = "utility"
	lefthand_file = 'icons/mob/inhands/equipment/belt_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/belt_righthand.dmi'
	slot_flags = INV_SLOTBIT_BELT
	attack_verb = list("whipped", "lashed", "disciplined")
	max_integrity = 300
	w_class = WEIGHT_CLASS_NORMAL // Okay they can go back in ur backpack
	var/content_overlays = FALSE //If this is true, the belt will gain overlays based on what it's holding
	var/onmob_overlays = FALSE //worn counterpart of the above.

/obj/item/storage/belt/update_overlays()
	. = ..()
	if(content_overlays)
		for(var/obj/item/I in contents)
			. += I.get_belt_overlay()

/obj/item/storage/belt/worn_overlays(isinhands, icon_file, used_state, style_flags = NONE)
	. = ..()
	if(!isinhands && onmob_overlays)
		for(var/obj/item/I in contents)
			. += I.get_worn_belt_overlay(icon_file)

/obj/item/storage/belt/Initialize()
	. = ..()
	update_icon()

/obj/item/storage/belt/ComponentInitialize()
	. = ..()
	if(onmob_overlays)
		AddElement(/datum/element/update_icon_updates_onmob)

/* * * *
 * BELTS
 * * * */

/////////////
// TOOLBELTS

/obj/item/storage/belt/utility
	name = "toolbelt" //Carn: utility belt is nicer, but it bamboozles the text parsing.
	desc = "Holds tools."
	icon_state = "utilitybelt"
	inhand_icon_state = "utility"
	content_overlays = TRUE
	custom_premium_price = 300
	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE //because this is easier than trying to have showers wash all contents.
	component_type = /datum/component/storage/concrete/belt/specialized/utility

/obj/item/storage/belt/utility/chief
	name = "\improper Chief Engineer's toolbelt" //"the Chief Engineer's toolbelt", because "Chief Engineer's toolbelt" is not a proper noun
	desc = "Holds tools, looks snazzy."
	icon_state = "utilitybelt_ce"
	inhand_icon_state = "utility_ce"

/obj/item/storage/belt/utility/full/engi/PopulateContents()
	new /obj/item/screwdriver/power(src)
	new /obj/item/crowbar/power(src)
	new /obj/item/weldingtool/experimental(src)//This can be changed if this is too much
	new /obj/item/multitool(src)
	new /obj/item/stack/cable_coil(src,30,pick("blue"))
	new /obj/item/extinguisher/mini(src)
	new /obj/item/analyzer/ranged(src)
	//much roomier now that we've managed to remove two tools

/obj/item/storage/belt/utility/full/PopulateContents()
	new /obj/item/screwdriver(src)
	new /obj/item/wrench(src)
	new /obj/item/weldingtool(src)
	new /obj/item/crowbar(src)
	new /obj/item/wirecutters(src)
	new /obj/item/multitool(src)
	new /obj/item/stack/cable_coil(src,30,pick("red"))

// Wasteland toolbelt
/obj/item/storage/belt/utility/waster
	name = "wastelander toolbelt"
	desc = "Holds a collection of simple tools."

/obj/item/storage/belt/utility/waster/PopulateContents()
	new /obj/item/crowbar/crude(src)
	new /obj/item/wrench/crude(src)
	new /obj/item/screwdriver/crude(src)
	new /obj/item/weldingtool/crude(src)
	new /obj/item/wirecutters/crude(src)
	new /obj/item/stack/cable_coil(src,30,pick("yellow","orange"))

// Forgemaster toolbelt (made to make the old chainsaw 2h component bearable, phase out unless needed, wasteland toobelt should suffice)
/obj/item/storage/belt/utility/waster/forgemaster
	name = "forgemasters toolbelt"
	desc = "Has a collection of basic tools and a hook rigging to sling a chainsaw from."

/obj/item/storage/belt/utility/waster/forgemaster/PopulateContents()
	new /obj/item/crowbar/crude(src)
	new /obj/item/wrench/crude(src)
	new /obj/item/screwdriver/crude(src)
	new /obj/item/weldingtool/crude(src)
	new /obj/item/wirecutters/crude(src)
	new /obj/item/melee/smith/hammer/premade(src)
	new /obj/item/twohanded/chainsaw(src)

/obj/item/storage/belt/durathread
	name = "durathread toolbelt"
	desc = "A toolbelt made out of durathread. Aside from the material being fireproof, this is virtually identical to a leather toolbelt."
	icon_state = "webbing-durathread"
	inhand_icon_state = "webbing-durathread"

/obj/item/storage/belt/utility/abductor
	name = "agent belt"
	desc = "A belt used by abductor agents."
	icon = 'icons/obj/abductor.dmi'
	icon_state = "belt"
	inhand_icon_state = "security"

/obj/item/storage/belt/utility/abductor/full/PopulateContents()
	new /obj/item/screwdriver/abductor(src)
	new /obj/item/wrench/abductor(src)
	new /obj/item/weldingtool/abductor(src)
	new /obj/item/crowbar/abductor(src)
	new /obj/item/wirecutters/abductor(src)
	new /obj/item/multitool/abductor(src)
	new /obj/item/stack/cable_coil(src,30,"white")

/obj/item/storage/belt/utility/waster
	name = "servant toolbelt"
	desc = "Holds a collection of simple tools."

/obj/item/storage/belt/utility/servant/PopulateContents()
	new /obj/item/screwdriver/brass(src)
	new /obj/item/wirecutters/brass(src)
	new /obj/item/wrench/brass(src)
	new /obj/item/weldingtool/experimental/brass(src)
	new /obj/item/multitool/advanced/brass(src)
	new /obj/item/stack/cable_coil(src, 30, "yellow")

/obj/item/storage/belt/utility/mining
	name = "explorer's webbing"
	desc = "A versatile chest rig, cherished by miners and hunters alike. Holds tools and tool-like things."
	icon_state = "explorer1"
	inhand_icon_state = "explorer1"

/obj/item/storage/belt/utility/mining/vendor
	contents = newlist(/obj/item/survivalcapsule)

/obj/item/storage/belt/utility/mining/alt
	icon_state = "explorer2"
	inhand_icon_state = "explorer2"

/obj/item/storage/belt/utility/mining/primitive
	name = "hunter's belt"
	desc = "A versatile belt, woven from sinew. Holds tools and tool-like things."
	icon_state = "ebelt"
	inhand_icon_state = "ebelt"
	component_type = /datum/component/storage/concrete/pockets/magpouch

// Gardener belt. Hold farming stuff thats small, also flasks (think hip flasks, not bottles as such)
/obj/item/storage/belt/utility/gardener
	name = "gardeners toolbelt"
	desc = "Leather belt with straps for various smaller farming equipment, bags and hip flasks."
	icon = 'icons/fallout/clothing/belts.dmi'
	icon_state = "gardener"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/belt.dmi'
	component_type = /datum/component/storage/concrete/belt/specialized/utility

/obj/item/storage/belt/janitor
	name = "janibelt"
	desc = "A belt used to hold most janitorial supplies."
	icon_state = "janibelt"
	inhand_icon_state = "janibelt"
	component_type = /datum/component/storage/concrete/belt/specialized/utility

//////////////////
/// Medical belts

/obj/item/storage/belt/medical
	name = "medical belt"
	desc = "Can hold various medical equipment."
	icon_state = "medicalbelt"
	inhand_icon_state = "medical"
	content_overlays = TRUE
	component_type = /datum/component/storage/concrete/belt/specialized/medical

/obj/item/storage/belt/medical/surgery_belt_adv
	name = "surgical supply belt"
	desc = "A specialized belt designed for holding surgical equipment. It seems to have specific pockets for each and every surgical tool you can think of."
	content_overlays = FALSE

/obj/item/storage/belt/medical/surgery_belt_adv/PopulateContents()
	new /obj/item/scalpel/advanced(src)
	new /obj/item/retractor/advanced(src)
	new /obj/item/surgicaldrill/advanced(src)
	new /obj/item/surgical_drapes/advanced(src)
	new /obj/item/bonesetter(src)
	new /obj/item/clothing/mask/surgical(src)
	new /obj/item/reagent_containers/medspray/sterilizine(src)
	new /obj/item/razor(src)
	new /obj/item/stack/sticky_tape/surgical(src)
	new /obj/item/stack/sticky_tape/surgical(src)
	new /obj/item/stack/medical/bone_gel(src)
	new /obj/item/stack/medical/bone_gel(src)

// Primitive medical belt, meant to be part of a ghetto surgery improvement at some point
/obj/item/storage/belt/medical/primitive
	name = "primitive medical toolbelt"
	desc = "This might look a bit like a toolbelt for a carpenter, but the items inside are meant to be used in surgery. No really."
	content_overlays = FALSE

/obj/item/storage/belt/medical/primitive/PopulateContents()
	new /obj/item/surgical_drapes(src)
	new /obj/item/scalpel (src)
	new /obj/item/handsaw(src)
	new /obj/item/retractor(src)
	new /obj/item/hemostat(src)
	new /obj/item/weldingtool(src)
	new /obj/item/bonesetter(src)

//////////////////
/// Generic belts

/obj/item/storage/belt/fannypack
	name = "fannypack"
	desc = "A dorky fannypack for keeping small items in."
	icon_state = "fannypack_leather"
	inhand_icon_state = "fannypack_leather"
	dying_key = DYE_REGISTRY_FANNYPACK
	custom_price = PRICE_ALMOST_CHEAP
	component_type = /datum/component/storage/concrete/belt

/obj/item/storage/belt/fannypack/black
	name = "black fannypack"
	icon_state = "fannypack_black"
	inhand_icon_state = "fannypack_black"

/obj/item/storage/belt/fannypack/orange
	name = "orange fannypack"
	icon_state = "fannypack_orange"
	inhand_icon_state = "fannypack_orange"

/obj/item/storage/belt/fannypack/pink
	name = "pink fannypack"
	icon_state = "fannypack_pink"
	inhand_icon_state = "fannypack_pink"

//////////////////
/// Belt holsters

/obj/item/storage/belt/legholster
	name = "hip holster"
	desc = "A side holster that goes on your belt and rests on your hip, and not your neck. Honestly who puts a gun up to their neck? WARNING: Badasses only."
	icon = 'icons/fallout/clothing/belts.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/belt.dmi'
	icon_state = "holster_leg"
	inhand_icon_state = "holster_leg"
	component_type = /datum/component/storage/concrete/belt/specialized/gun

/obj/item/storage/belt/legholster/police/PopulateContents()
	new /obj/item/gun/ballistic/revolver/police(src)
	new /obj/item/ammo_box/a357(src)
	new /obj/item/ammo_box/a357(src)
	new /obj/item/ammo_box/a357(src)

///////////////////
/// Belt bandolier

/obj/item/storage/belt/military
	name = "chest rig"
	desc = "A mean-looking belt sack for holding lots of ammo."
	icon_state = "militarywebbing"
	inhand_icon_state = "militarywebbing"
	slot_flags = INV_SLOTBIT_BELT
	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE
	component_type = /datum/component/storage/concrete/belt/specialized/bandolier

/obj/item/storage/belt/military/alt
	icon_state = "explorer2"
	inhand_icon_state = "explorer2"

/obj/item/storage/belt/military/reconbandolier
	name = "NCR recon ranger bandolier"
	desc = "A belt with many pockets, now at an angle."
	icon_state = "reconbandolier"
	inhand_icon_state = "reconbandolier"

/obj/item/storage/belt/military/NCR_Bandolier
	name = "NCR bandolier"
	desc = "A standard issue NCR bandolier."
	icon_state = "ncr_bandolier"
	inhand_icon_state = "ncr_bandolier"

/obj/item/storage/belt/army
	name = "army belt"
	desc = "A robust belt for holding things like guns."
	icon_state = "grenadebeltold"
	inhand_icon_state = "security"
	component_type = /datum/component/storage/concrete/belt/specialized/bandolier

/obj/item/storage/belt/army/followers
	name = "guild knight belt"
	desc = "A thoughtful belt for holding things like guns."
	icon_state = "grenadebeltold"
	inhand_icon_state = "security"

/obj/item/storage/belt/army/followers/PopulateContents()
	new /obj/item/reagent_containers/spray/pepper(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/melee/classic_baton(src)
	new /obj/item/melee/onehanded/knife/hunting(src)
	update_icon()

/obj/item/storage/belt/army/security
	name = "security belt"
	desc = "Robust belt for holding robust things, like guns."
	icon_state = "securitybelt"
	inhand_icon_state = "security"//Could likely use a better one.
	content_overlays = TRUE

/obj/item/storage/belt/army/security/full/PopulateContents()
	new /obj/item/reagent_containers/spray/pepper(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/grenade/flashbang(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/melee/baton/loaded(src)
	update_icon()

/obj/item/storage/belt/army/assault
	name = "assault belt"
	desc = "A sweet tactical belt for holding guns."
	icon_state = "assaultbelt"
	inhand_icon_state = "security"

/obj/item/storage/belt/army/assault/legion
	name = "legionnaire marching belt"
	desc = "Sturdy leather belt with a red decorative sash."
	icon = 'icons/fallout/clothing/belts.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/belt.dmi'
	icon_state = "belt_legion"
	inhand_icon_state = "belt_legion"

/obj/item/storage/belt/army/assault/enclave
	name = "old style army belt"
	desc = "prefall army utility belt design."
	icon_state = "enclave_belt"
	inhand_icon_state = "enclave_belt"

/obj/item/storage/belt/army/assault/ncr
	name = "NCR patrol belt"
	desc = "A standard issue robust duty belt for the NCR."
	icon_state = "ncr_belt"
	inhand_icon_state = "ncr_belt"

/obj/item/storage/belt/army/assault/ncr/engineer
	name = "NCR engineer belt"
	desc = "A standard issue robust duty belt for the NCR."
	icon_state = "ncr_belt"
	inhand_icon_state = "ncr_belt"

/// snackdolier
/obj/item/storage/belt/military/snack
	name = "tactical snack rig"
	desc = "Snackrolling the Mojavelicious fillmost caramakel you satiswish for a nuclear whunger"

/obj/item/storage/belt/military/snack/Initialize()
	. = ..()
	var/sponsor = pick("DonkCo", "Waffle Co.", "Roffle Co.", "Gorlax Marauders", "Tiger Cooperative")
	desc = "A set of snack-tical webbing worn by athletes of the [sponsor] VR sports division."

/obj/item/storage/belt/military/snack/PopulateContents()
	var/rigsnax
	for(var/snackies in 1 to 21)
		rigsnax = pick(list(
		/obj/item/reagent_containers/food/snacks/candy,
		/obj/item/reagent_containers/food/drinks/dry_ramen,
		/obj/item/reagent_containers/food/snacks/chips,
		/obj/item/reagent_containers/food/snacks/sosjerky,
		/obj/item/reagent_containers/food/snacks/syndicake,
		/obj/item/reagent_containers/food/snacks/spacetwinkie,
		/obj/item/reagent_containers/food/snacks/cheesiehonkers,
		/obj/item/reagent_containers/food/snacks/nachos,
		/obj/item/reagent_containers/food/snacks/cheesynachos,
		/obj/item/reagent_containers/food/snacks/cubannachos,
		/obj/item/reagent_containers/food/snacks/nugget,
		/obj/item/reagent_containers/food/snacks/pastatomato,
		/obj/item/reagent_containers/food/snacks/rofflewaffles,
		/obj/item/reagent_containers/food/snacks/donkpocket,
		/obj/item/reagent_containers/food/drinks/soda_cans/cola,
		/obj/item/reagent_containers/food/drinks/soda_cans/space_mountain_wind,
		/obj/item/reagent_containers/food/drinks/soda_cans/dr_gibb,
		/obj/item/reagent_containers/food/drinks/soda_cans/starkist,
		/obj/item/reagent_containers/food/drinks/soda_cans/space_up,
		/obj/item/reagent_containers/food/drinks/soda_cans/pwr_game,
		/obj/item/reagent_containers/food/drinks/soda_cans/lemon_lime,
		/obj/item/reagent_containers/food/drinks/drinkingglass/filled/nuka_cola,
		/obj/item/reagent_containers/food/drinks/drinkingglass/filled/syndicatebomb
		))
		new rigsnax(src)

/obj/item/storage/belt/military/plush
	name = "tactical plushie rig"
	desc = "a set of military grade tactical pouches, made to hold a large number of plushies."
	component_type = /datum/component/storage/concrete/belt/specialized/plush

/obj/item/storage/belt/military/plush/PopulateContents()
	var/rigplush
	for(var/plooshies in 1 to 21)
		rigplush = pick(GLOB.valid_plushie_paths)
		new rigplush(src)

/* * * * * * *
 * NECKPRONS
 * * * * * * */

///////////////
/// Bandoliers
/obj/item/storage/belt/bandolier
	name = "bandolier"
	desc = "An over-the-shoulder length of webbing that can hold all sorts of ammostuffs."
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_state = "bandolier"
	inhand_icon_state = "bandolier"
	slot_flags = INV_SLOTBIT_NECK
	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE
	component_type = /datum/component/storage/concrete/neckpron/specialized/bandolier

/obj/item/storage/belt/bandolier/durathread
	name = "durathread bandolier"
	desc = "A drab looking bandolier that goes on your upper body."
	icon_state = "bandolier"
	inhand_icon_state = "bandolier"
	slot_flags = INV_SLOTBIT_NECK
	resistance_flags = FIRE_PROOF

/////////////////
/// Neck Gunbelt
/obj/item/storage/belt/shoulderholster
	name = "standard holster"
	desc = "An over the shoulder shooter holder. WARNING: Badasses only. Fits 4 weapons"
	icon = 'icons/fallout/clothing/belts.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/belt.dmi'
	icon_state = "holster_shoulder"
	inhand_icon_state = "holster_shoulder"
	alternate_worn_layer = UNDER_SUIT_LAYER
	slot_flags = INV_SLOTBIT_NECK | INV_SLOTBIT_MASK
	component_type = /datum/component/storage/concrete/pockets/bos/paladin //4 slots instead of 3

/obj/item/storage/belt/shoulderholster/full/PopulateContents()
	new /obj/item/gun/ballistic/revolver/detective(src)
	new /obj/item/ammo_box/c22(src)
	new /obj/item/ammo_box/c22(src)

/obj/item/storage/belt/shoulderholster/ranger44/PopulateContents()
	new /obj/item/gun/ballistic/revolver/revolver44(src)
	new /obj/item/ammo_box/m44(src)
	new /obj/item/ammo_box/m44(src)
	new /obj/item/ammo_box/m44(src)

/obj/item/storage/belt/shoulderholster/ranger357/PopulateContents()
	new /obj/item/gun/ballistic/revolver/colt357(src)
	new /obj/item/ammo_box/a357(src)
	new /obj/item/ammo_box/a357(src)
	new /obj/item/ammo_box/a357(src)

/obj/item/storage/belt/shoulderholster/ranger45/PopulateContents()
	new /obj/item/gun/ballistic/revolver/revolver45(src)
	new /obj/item/ammo_box/c45rev(src)
	new /obj/item/ammo_box/c45rev(src)
	new /obj/item/ammo_box/c45rev(src)

/obj/item/storage/belt/shoulderholster/ranger4570/PopulateContents()
	new /obj/item/gun/ballistic/revolver/sequoia(src)
	new /obj/item/ammo_box/c4570(src)
	new /obj/item/ammo_box/c4570(src)
	new /obj/item/ammo_box/c4570(src)

/obj/item/storage/belt/shoulderholster/ranger4570bayonet/PopulateContents()
	new /obj/item/gun/ballistic/revolver/sequoia/bayonet(src)
	new /obj/item/ammo_box/c4570(src)
	new /obj/item/ammo_box/c4570(src)
	new /obj/item/ammo_box/c4570(src)

/obj/item/storage/belt/outlawscloak
	name = "outlaws cloak"
	desc = "A sturdy, thick poncho made from burlap. Comes with a salvaged shoulderpad and a hidden armpit holster."
	icon = 'icons/fallout/clothing/belts.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/belt.dmi'
	icon_state = "outlaws_cloak"
	inhand_icon_state = "outlaws_cloak"
	body_parts_covered = CHEST|GROIN|ARMS
	slot_flags = INV_SLOTBIT_NECK
	component_type = /datum/component/storage/concrete/neckpron/specialized/gun

/obj/item/storage/belt/peacefulcoat
	name = "peacetakers jacket"
	desc = "A mangy bomber jacket haphazardly patched up and reinforced with old bits of armor and metal plates. Someone spraypainted a peace-sign on its back... Comes with a holster."
	icon = 'icons/fallout/clothing/belts.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/belt.dmi'
	icon_state = "peacefulcoat"
	inhand_icon_state = "peacefulcoat"
	body_parts_covered = CHEST|GROIN|ARMS
	slot_flags = INV_SLOTBIT_NECK
	component_type = /datum/component/storage/concrete/neckpron/specialized/gun

/obj/item/storage/belt/poachercoat
	name = "poachers coat"
	desc = "A makeshift coat made out of salvaged vault-suits haphazardly stitched together. Comes with a pelt collar, salvaged armor parts and a hidden holster."
	icon = 'icons/fallout/clothing/belts.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/belt.dmi'
	icon_state = "poachercoat"
	inhand_icon_state = "poachercoat"
	body_parts_covered = CHEST|GROIN|ARMS
	slot_flags = INV_SLOTBIT_NECK
	component_type = /datum/component/storage/concrete/neckpron/specialized/gun

/obj/item/storage/belt/poachervest
	name = "poachers vest"
	desc = "A makeshift vest made out of salvaged vault-suits haphazardly stitched together. Comes with a pelt collar, leather bits and a shoulder holster hidden underneath."
	icon = 'icons/fallout/clothing/belts.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/belt.dmi'
	icon_state = "poachervest"
	inhand_icon_state = "poachervest"
	body_parts_covered = CHEST|GROIN|ARMS
	slot_flags = INV_SLOTBIT_NECK
	component_type = /datum/component/storage/concrete/neckpron/specialized/gun

/obj/item/storage/belt/dantecoat
	name = "mercenary trenchcoat"
	desc = "A flashy red trenchcoat with rolled back sleeves, brass details and a zipper. Has a twin-holster integrated on the outside. For when there is a storm approaching and you gotta pull your devil trigger."
	icon = 'icons/fallout/clothing/belts.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/belt.dmi'
	icon_state = "dantecoat"
	inhand_icon_state = "dantecoat"
	body_parts_covered = CHEST|GROIN|ARMS
	slot_flags = INV_SLOTBIT_NECK
	component_type = /datum/component/storage/concrete/neckpron/specialized/gun

//////////////////
/// Neck medibelt

/obj/item/storage/belt/medolier
	name = "medolier"
	desc = "An over the shoulder medical holder, lifts and separates medical supplies to make you a more appealing healer."
	icon_state = "medolier"
	inhand_icon_state = "medolier"
	slot_flags = INV_SLOTBIT_NECK
	component_type = /datum/component/storage/concrete/neckpron/specialized/medical

/*	STR.max_items = 15
	STR.display_numerical_stacking = FALSE
	STR.allow_quick_gather = TRUE
	STR.allow_quick_empty = TRUE
	STR.click_gather = TRUE
	STR.can_hold = typecacheof(list(/obj/item/reagent_containers/syringe/dart)) + GLOB.medibelt_allowed

/obj/item/storage/belt/medolier/full/PopulateContents()
	for(var/i in 1 to 16)
		new /obj/item/reagent_containers/syringe/dart/(src)

/obj/item/storage/belt/medolier/afterattack(obj/target, mob/user , proximity)
	if(!(istype(target, /obj/item/reagent_containers/glass/beaker)))
		return
	if(!proximity)
		return
	if(!target.reagents)
		return

	for(var/obj/item/reagent_containers/syringe/dart/D in contents)
		if(round(target.reagents.total_volume, 1) <= 0)
			to_chat(user, span_notice("You soak as many of the darts as you can with the contents from [target]."))
			return
		if(D.mode == SYRINGE_INJECT)
			continue

		D.afterattack(target, user, proximity)

	..() */ // Kinda messes with things



/* * * * * * * * * * * *
 * Other belts and such
 * * * * * * * * * * * */

/obj/item/storage/belt/champion
	name = "championship belt"
	desc = "Proves to the world that you are the strongest!"
	icon_state = "championbelt"
	inhand_icon_state = "champion"
	custom_materials = list(/datum/material/gold=400)

/obj/item/storage/belt/champion/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 1

///grenade belt
/obj/item/storage/belt/grenade
	name = "grenadier belt"
	desc = "A belt for holding grenades."
	icon_state = "grenadebeltnew"
	inhand_icon_state = "security"
	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE

/obj/item/storage/belt/grenade/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 30
	STR.display_numerical_stacking = TRUE
	STR.max_combined_w_class = 60
	STR.max_w_class = WEIGHT_CLASS_BULKY

/obj/item/storage/belt/grenade/full/PopulateContents()
	new /obj/item/grenade/flashbang(src)
	new /obj/item/grenade/smokebomb(src)
	new /obj/item/grenade/smokebomb(src)
	new /obj/item/grenade/smokebomb(src)
	new /obj/item/grenade/smokebomb(src)
	new /obj/item/grenade/empgrenade(src)
	new /obj/item/grenade/empgrenade(src)
	new /obj/item/grenade/frag(src)
	new /obj/item/grenade/frag(src)
	new /obj/item/grenade/frag(src)
	new /obj/item/grenade/frag(src)
	new /obj/item/grenade/frag(src)
	new /obj/item/grenade/frag(src)
	new /obj/item/grenade/frag(src)
	new /obj/item/grenade/frag(src)
	new /obj/item/grenade/frag(src)
	new /obj/item/grenade/frag(src)
	new /obj/item/grenade/gluon(src)
	new /obj/item/grenade/gluon(src)
	new /obj/item/grenade/gluon(src)
	new /obj/item/grenade/gluon(src)
	new /obj/item/grenade/chem_grenade/incendiary(src)
	new /obj/item/grenade/chem_grenade/incendiary(src)
	new /obj/item/grenade/chem_grenade/facid(src)
	new /obj/item/grenade/syndieminibomb(src)
	new /obj/item/grenade/syndieminibomb(src)
	new /obj/item/screwdriver(src)
	new /obj/item/multitool(src)

///Knifebelts
/obj/item/storage/belt/sabre
	name = "sword sheath"
	desc = "A fine sheath for carrying a sword in style."
	icon_state = "utilitybelt"
	inhand_icon_state = "utility"
	w_class = WEIGHT_CLASS_BULKY
	content_overlays = TRUE
	onmob_overlays = TRUE
	var/list/fitting_swords = list(/obj/item/melee/sabre, /obj/item/melee/baton/stunsword)
	var/starting_sword = /obj/item/melee/sabre

/obj/item/storage/belt/sabre/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 1
	STR.max_w_class = WEIGHT_CLASS_BULKY
	STR.max_combined_w_class = 4
	STR.can_hold = typecacheof(fitting_swords)
	STR.quickdraw = TRUE

/obj/item/storage/belt/sabre/examine(mob/user)
	. = ..()
	if(length(contents))
		. += span_notice("Alt-click it to quickly draw the blade.")

/obj/item/storage/belt/sabre/PopulateContents()
	if(ispath(starting_sword))
		new starting_sword(src)

/obj/item/storage/belt/sabre/heavy
	name = "heavy-duty sheath"
	desc = "A rugged set of leather straps and metal tips to comfortably carry a large variety of blades (and even blunt objects) on your side."
	icon_state = "sheath"
	inhand_icon_state = "sheath"
	w_class = WEIGHT_CLASS_BULKY
	content_overlays = TRUE
	onmob_overlays = TRUE
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_BACK
	starting_sword = null

/obj/item/storage/belt/sabre/heavy/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 1
	STR.max_w_class = WEIGHT_CLASS_BULKY
	STR.max_combined_w_class = 4
	STR.can_hold = typecacheof(list(/obj/item/melee, /obj/item/twohanded))
	STR.quickdraw = TRUE

/obj/item/storage/belt/sabre/knife
	name = "knife bandolier"
	desc = "A bandolier lined with loops, perfect for slipping in a few small blades."
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_state = "bandolier"
	inhand_icon_state = "bandolier"
	w_class = WEIGHT_CLASS_BULKY
	content_overlays = TRUE
	onmob_overlays = TRUE
	slot_flags = INV_SLOTBIT_NECK
	starting_sword = null

/obj/item/storage/belt/sabre/knife/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage) //up to seven knives and daggers
	STR.max_items = STORAGE_BELT_SPECIALIZED_MAX_ITEMS
	STR.max_w_class = STORAGE_BELT_SPECIALIZED_MAX_SIZE
	STR.max_combined_w_class = STORAGE_BELT_SPECIALIZED_MAX_TOTAL_SPACE
	STR.can_hold = typecacheof(list(/obj/item/melee, /obj/item/twohanded)) //any small sized stabby
	STR.quickdraw = TRUE

/obj/item/storage/belt/sabre/rapier
	name = "rapier sheath"
	desc = "A sinister, thin sheath, suitable for a rapier."
	icon_state = "rsheath"
	inhand_icon_state = "rsheath"
	force = 5
	throwforce = 15
	w_class = WEIGHT_CLASS_BULKY
	attack_verb = list("bashed", "slashes", "prods", "pokes")
	fitting_swords = list(/obj/item/melee/rapier)
	starting_sword = /obj/item/melee/rapier


/obj/item/storage/belt/sword // new that works
	name = "sword sheath"
	desc = "A fine sheath for carrying a sword in style."
	icon = 'icons/fallout/clothing/belts.dmi'
	icon_state = "sheath_sword"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/belt.dmi'
	inhand_icon_state = "sheath_sword"
	w_class = WEIGHT_CLASS_BULKY
	content_overlays = TRUE
	onmob_overlays = TRUE
	slot_flags = INV_SLOTBIT_NECK

/obj/item/storage/belt/sword/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 1
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.max_combined_w_class = 3
	STR.can_hold = typecacheof(list(/obj/item/melee, /obj/item/twohanded))
	STR.quickdraw = TRUE

// Instead of half-assed broken weaboo stuff lets have something that works.
/obj/item/storage/belt/sword/twin
	name = "daishō"
	desc = "A set of sheathes and straps for carrying two curved japanese style swords."
	icon_state = "sheath_twin"
	inhand_icon_state = "sheath_twin"
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_BACK

/obj/item/storage/belt/sword/twin/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 2
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.max_combined_w_class = 6
	STR.can_hold = typecacheof(list(/obj/item/melee, /obj/item/twohanded))
	STR.quickdraw = TRUE

/obj/item/storage/belt/waistsheath
	name = "sword sheath"
	desc = "A utility belt that allows a sword to be held at the hip at the cost of storage space."
	icon_state = "sheathwaist"
	inhand_icon_state = "sheathwaist"
	w_class = WEIGHT_CLASS_BULKY

/obj/item/storage/belt/waistsheath/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 2
	STR.rustle_sound = FALSE
	STR.max_w_class = WEIGHT_CLASS_BULKY
	STR.can_hold = typecacheof(list(
		/obj/item/storage/belt/waistsheathstorage,
		/obj/item/melee/onehanded/machete,
		))

/obj/item/storage/belt/waistsheath/examine(mob/user)
	..()
	if(length(contents))
		to_chat(user, span_notice("Alt-click it to quickly draw the blade."))

/obj/item/storage/belt/waistsheath/AltClick(mob/user)
	if(!iscarbon(user) || !user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	if(length(contents))
		var/obj/item/I = contents[2]
		user.visible_message("[user] takes [I] out of [src].", span_notice("You take [I] out of [src]."))
		user.put_in_hands(I)
		update_icon()
	else
		to_chat(user, "[src] is empty.")

/obj/item/storage/belt/waistsheath/update_icon()
	icon_state = "sheathwaist"
	inhand_icon_state = "sheathwaist"
	if(contents.len == 2)
		icon_state += "-full"
		inhand_icon_state += "-full"
	if(loc && isliving(loc))
		var/mob/living/L = loc
		L.regenerate_icons()
	..()

/obj/item/storage/belt/waistsheath/PopulateContents()
	new /obj/item/storage/belt/waistsheathstorage(src)
	update_icon()

/obj/item/storage/belt/waistsheathstorage
	name = "open inventory"
	desc = "Open your belt's inventory"
	icon_state = "open"
	anchored = 1

/obj/item/storage/belt/waistsheathstorage/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_GIGANTIC
	STR.max_items = 5
	STR.clickopen = TRUE

//NCR Ranger's stuff

/obj/item/storage/belt/military/commonwealth_brit
	name = "Pattern 37 webbing"
	desc = "A versatile chest rig, this one seems to be used in jungle enviroments and such"
	icon_state = "brit_web"
	inhand_icon_state = "brit_web"
	icon = 'icons/fallout/clothing/belts.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/belt.dmi'

/obj/item/storage/belt/military/commonwealth_brit/oldschool
	name = "Pattern 1908 webbing"
	desc = "A versatile chest rig, this one seems to be used in the great war by Great Britain and the commonwealth."
	icon_state = "brit_webww1"
	inhand_icon_state = "brit_webww1"
	icon = 'icons/fallout/clothing/belts.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/belt.dmi'

/obj/item/storage/belt/bandolier/boer_band
	name = " Boar War Leather Band"
	desc = "An old style of bandolier used by primarily those who ride upon horses. Used in the boer war."
	icon_state = "boer"
	inhand_icon_state = "boer"
	icon = 'icons/fallout/clothing/belts.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/belt.dmi'

/obj/item/storage/belt/military/french_webbing
	name = "french webbing"
	desc = "A versatile chest rig, this one seems to be used in long bread enviroments and such"
	icon_state = "french_webbing"
	inhand_icon_state = "french_webbing"

/obj/item/storage/belt/legholster/throwing
	name = "garter rig"
	desc = "A series of straps and clips that goes where you would typically wrap a garter belt. Leaves your (non-)lethal implements hanging snugly and discreetly!"
	icon = 'icons/fallout/clothing/belts.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/belt.dmi'
	icon_state = "holster_leg"
	inhand_icon_state = "holster_leg"
	component_type = /datum/component/storage/concrete/pockets/magpouch

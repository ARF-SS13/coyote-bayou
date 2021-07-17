/obj/item/melee/powerfist
	name = "powerfist"
	desc = "A metal gauntlet with a piston-powered ram on top for that extra 'oomph' in your punch."
	icon_state = "powerfist"
	item_state = "powerfist"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	flags_1 = CONDUCT_1
	attack_verb = list("whacked", "fisted", "power-punched")
	force = 25
	armour_penetration = 0.7
	throwforce = 10
	throw_range = 7
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_GLOVES
	var/transfer_prints = TRUE //prevents runtimes with forensics when held in glove slot
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 40)


/obj/item/melee/powerfist/goliath //Placeholder for now, just straight powerfist copy with tiny AP increase. Maybe fine?
	name = "Goliath"
	desc = "Armored gauntlet with a piston-powered ram, this one is a experimental one captured and named by the Legion."
	icon_state = "goliath"
	item_state = "goliath"
	armour_penetration = 0.85


/obj/item/gun/ballistic/revolver/ballisticfist //it's a double-barrel shotgun disguised as a fist shhh
	name = "ballistic fist"
	desc = "This powerfist has been modified to have two shotgun barrels welded to it, with the trigger integrated into the knuckle guard. For those times when you want to punch someone and shoot them in the face at the same time."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "ballisticfist"
	item_state = "powerfist"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	force = 30
	armour_penetration = 0.7
	mag_type = /obj/item/ammo_box/magazine/internal/shot/dual
	fire_sound = 'sound/f13weapons/caravan_shotgun.ogg'
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_GLOVES
	w_class = WEIGHT_CLASS_NORMAL
	item_flags = NEEDS_PERMIT //doesn't slow you down
	fire_delay = 0
//	distro = 1
	var/transfer_prints = TRUE //prevents runtimes with forensics when held in glove slot



/obj/item/melee/powerfist/moleminer
	name = "mole miner gauntlet"
	desc = "A hand-held mining and cutting implement, repurposed into a deadly melee weapon.  Its name origins are a mystery..."
	icon_state = "mole_miner_g"
	item_state = "mole_miner_g"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	flags_1 = CONDUCT_1
	force = 40
	armour_penetration = 0.5
	throwforce = 10
	throw_range = 7
	attack_verb = list("slashed", "sliced", "torn", "ripped", "diced", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_GLOVES
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

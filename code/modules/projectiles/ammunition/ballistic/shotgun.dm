// Shotgun

/obj/item/ammo_casing/shotgun
	name = "shotgun slug"
	desc = "A 12 gauge lead slug."
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "bbshell"
	caliber = CALIBER_SHOTGUN
	projectile_type = /obj/item/projectile/bullet/shotgun_slug
	material_class = BULLET_IS_SHOTGUN
	casing_quality = BULLET_IS_SURPLUS
	custom_materials = list(
		/datum/material/iron = MATS_SHOTGUN_CASING + MATS_SHOTGUN_BULLET,
		/datum/material/blackpowder = MATS_SHOTGUN_POWDER)
	fire_power = CASING_POWER_SHOTGUN * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_SHOTGUN

/obj/item/ammo_casing/shotgun/buckshot
	name = "buckshot shell"
	desc = "A 12 gauge buckshot shell."
	icon_state = "gshell"
	projectile_type = /obj/item/projectile/bullet/pellet/shotgun_buckshot
	pellets = SHOTGUN_PELLET_BASE
	variance = SHOTGUN_SPREAD_BASE
	fire_power = CASING_POWER_SHOTGUN * CASING_POWER_MOD_SURPLUS

/obj/item/ammo_casing/shotgun/buckshot/wide
	name = "supermagnum shell"
	desc = "A 12 gauge buckshot shell."
	icon_state = "gshell"
	projectile_type = /obj/item/projectile/bullet/pellet/shotgun_buckshot
	pellets = 20
	variance = 25

/obj/item/ammo_casing/shotgun/needlerbuckshot
	name = "Crystal needler shotgun shell"
	desc = "A small gauge shell filled with crystal needlers."
	icon_state = "hnsg"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	projectile_type = /obj/item/projectile/bullet/pellet/needler_buckshot
	pellets = SHOTGUN_PELLET_NEEDLER
	variance = SHOTGUN_SPREAD_BASE
	fire_power = CASING_POWER_SHOTGUN * CASING_POWER_MOD_SURPLUS
	material_class = BULLET_IS_SHOTGUN
	casing_quality = BULLET_IS_SURPLUS
	custom_materials = list(
		/datum/material/iron = MATS_SHOTGUN_CASING + MATS_SHOTGUN_BULLET,
		/datum/material/blackpowder = MATS_SHOTGUN_POWDER)
	fire_power = CASING_POWER_SHOTGUN * CASING_POWER_MOD_SURPLUS
	sound_properties = CSP_SHOTGUN

/obj/item/ammo_casing/shotgun/improvised
	name = "improvised shell"
	desc = "An extremely weak shotgun shell with multiple small pellets made out of metal shards."
	icon_state = "improvshell"
	projectile_type = /obj/item/projectile/bullet/pellet/shotgun_improvised
	pellets = SHOTGUN_PELLET_IMPROVISED
	variance = SHOTGUN_SPREAD_IMPROVISED
	casing_quality = BULLET_IS_HANDLOAD
	custom_materials = list(
		/datum/material/iron = (MATS_SHOTGUN_CASING * MATS_AMMO_CASING_HANDLOAD_MULT) + (MATS_SHOTGUN_BULLET * MATS_AMMO_BULLET_HANDLOAD_MULT),
		/datum/material/blackpowder = MATS_SHOTGUN_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_SHOTGUN * CASING_POWER_MOD_HANDLOAD

/obj/item/ammo_casing/shotgun/improvised/simplemob
	projectile_type = /obj/item/projectile/bullet/pellet/simplemob
	pellets = SHOTGUN_PELLET_IMPROVISED * 2 // double the pellets, but half the damage of each, doubles the effectiveness of armor
	variance = SHOTGUN_SPREAD_IMPROVISED * 3

/obj/item/ammo_casing/shotgun/beanbag
	name = "beanbag slug"
	desc = "A weak beanbag slug for riot control."
	icon_state = "bshell"
	projectile_type = /obj/item/projectile/bullet/shotgun_beanbag
	material_class = BULLET_IS_SHOTGUN
	casing_quality = BULLET_IS_RUBBER
	custom_materials = list(
		/datum/material/iron = MATS_SHOTGUN_CASING + MATS_SHOTGUN_BULLET,
		/datum/material/blackpowder = MATS_SHOTGUN_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_SHOTGUN * CASING_POWER_MOD_HANDLOAD

/obj/item/ammo_casing/shotgun/executioner
	name = "executioner slug"
	desc = "A 12 gauge lead slug purpose built to annihilate flesh on impact."
	icon_state = "stunshell"
	projectile_type = /obj/item/projectile/bullet/shotgun_slug/executioner
	fire_power = CASING_POWER_SHOTGUN * CASING_POWER_MOD_MATCH

/obj/item/ammo_casing/shotgun/pulverizer
	name = "pulverizer slug"
	desc = "A 12 gauge lead slug purpose built to annihilate bones on impact."
	icon_state = "stunshell"
	projectile_type = /obj/item/projectile/bullet/shotgun_slug/pulverizer
	fire_power = CASING_POWER_SHOTGUN * CASING_POWER_MOD_MATCH

/obj/item/ammo_casing/shotgun/incendiary
	name = "incendiary slug"
	desc = "An incendiary-coated shotgun slug."
	icon_state = "ishell"
	projectile_type = /obj/item/projectile/bullet/incendiary/shotgun
	fire_power = CASING_POWER_SHOTGUN * CASING_POWER_MOD_HANDLOAD

/obj/item/ammo_casing/shotgun/dragonsbreath
	name = "dragonsbreath shell"
	desc = "A shotgun shell which fires a spread of incendiary pellets."
	icon_state = "ishell2"
	projectile_type = /obj/item/projectile/bullet/incendiary/shotgun/dragonsbreath
	pellets = 4
	variance = 35
	fire_power = CASING_POWER_SHOTGUN * CASING_POWER_MOD_HANDLOAD

/obj/item/ammo_casing/shotgun/stunslug
	name = "taser slug"
	desc = "A stunning taser slug."
	icon_state = "stunshell"
	projectile_type = /obj/item/projectile/bullet/shotgun_stunslug
	material_class = BULLET_IS_SHOTGUN
	casing_quality = BULLET_IS_RUBBER
	custom_materials = list(
		/datum/material/iron = MATS_SHOTGUN_CASING + MATS_SHOTGUN_BULLET,
		/datum/material/blackpowder = MATS_SHOTGUN_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_SHOTGUN * CASING_POWER_MOD_HANDLOAD

/obj/item/ammo_casing/shotgun/meteorslug
	name = "meteorslug shell"
	desc = "A shotgun shell rigged with CMC technology, which launches a massive slug when fired."
	icon_state = "mshell"
	projectile_type = /obj/item/projectile/bullet/shotgun_meteorslug
	fire_power = CASING_POWER_SHOTGUN * CASING_POWER_MOD_MATCH

/obj/item/ammo_casing/shotgun/pulseslug
	name = "pulse slug"
	desc = "A delicate device which can be loaded into a shotgun. The primer acts as a button which triggers the gain medium and fires a powerful \
	energy blast. While the heat and power drain limit it to one use, it can still allow an operator to engage targets that ballistic ammunition \
	would have difficulty with."
	icon_state = "pshell"
	projectile_type = /obj/item/projectile/beam/pulse/shotgun
	fire_power = CASING_POWER_SHOTGUN * CASING_POWER_MOD_MATCH

/obj/item/ammo_casing/shotgun/frag12
	name = "FRAG-12 slug"
	desc = "A high explosive breaching round for a 12 gauge shotgun."
	icon_state = "heshell"
	projectile_type = /obj/item/projectile/bullet/shotgun_frag12
	fire_power = CASING_POWER_SHOTGUN * CASING_POWER_MOD_MATCH

/obj/item/ammo_casing/shotgun/rubbershot
	name = "rubber shot"
	desc = "A shotgun casing filled with densely-packed rubber balls, used to incapacitate crowds from a distance."
	icon_state = "bshell"
	projectile_type = /obj/item/projectile/bullet/pellet/shotgun_rubbershot
	pellets = SHOTGUN_PELLET_BASE
	variance = SHOTGUN_SPREAD_BASE
	material_class = BULLET_IS_SHOTGUN
	casing_quality = BULLET_IS_RUBBER
	custom_materials = list(
		/datum/material/iron = MATS_SHOTGUN_CASING + MATS_SHOTGUN_BULLET,
		/datum/material/blackpowder = MATS_SHOTGUN_POWDER * MATS_AMMO_POWDER_HANDLOAD_MULT)
	fire_power = CASING_POWER_SHOTGUN * CASING_POWER_MOD_HANDLOAD

/obj/item/ammo_casing/shotgun/bloatfly
	name = "bloatfly chunks"
	desc = "A gross pressurized stinger... thing that spits out a spray of gunk. ew."
	icon_state = "bshell"
	projectile_type = /obj/item/projectile/bullet/pellet/bloatfly_chunk
	pellets = 1
	variance = SHOTGUN_SPREAD_IMPROVISED

/obj/item/ammo_casing/shotgun/bloatfly/two
	pellets = 2

/obj/item/ammo_casing/shotgun/bloatfly/three
	pellets = 3

/obj/item/projectile/bullet/pellet/bloatfly_chunk
	name = "fly chunk"
	icon_state = "magspear"
	damage = 2
	stamina = 2
	spread = 20
	recoil = 0

	wound_bonus = -100
	bare_wound_bonus = -100
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT
	
	pixels_per_second = BULLET_SPEED_SHOTGUN_PELLET * 0.25
	zone_accuracy_type = ZONE_WEIGHT_SHOTGUN

/obj/item/ammo_casing/shotgun/ion
	name = "ion shell"
	desc = "An advanced shotgun shell which uses a subspace ansible crystal to produce an effect similar to a standard ion rifle. \
	The unique properties of the crystal split the pulse into a spread of individually weaker bolts."
	icon_state = "ionshell"
	projectile_type = /obj/item/projectile/ion/weak
	pellets = 4
	variance = 35
	fire_power = CASING_POWER_SHOTGUN * CASING_POWER_MOD_MATCH

/obj/item/ammo_casing/shotgun/laserslug
	name = "scatter laser shell"
	desc = "An advanced shotgun shell that uses a micro laser to replicate the effects of a scatter laser weapon in a ballistic package."
	icon_state = "lshell"
	projectile_type = /obj/item/projectile/beam/scatter
	pellets = 6
	variance = 35
	fire_power = CASING_POWER_SHOTGUN * CASING_POWER_MOD_MATCH

/obj/item/ammo_casing/shotgun/techshell
	name = "unloaded technological shell"
	desc = "A high-tech shotgun shell which can be loaded with materials to produce unique effects."
	icon_state = "cshell"
	projectile_type = null
	fire_power = CASING_POWER_SHOTGUN * CASING_POWER_MOD_MATCH

/obj/item/ammo_casing/shotgun/dart
	name = "shotgun dart"
	desc = "A dart for use in shotguns. Can be injected with up to 30 units of any chemical."
	icon_state = "cshell"
	projectile_type = /obj/item/projectile/bullet/dart
	var/reagent_amount = 30
	fire_power = CASING_POWER_SHOTGUN * CASING_POWER_MOD_MATCH

/obj/item/ammo_casing/shotgun/dart/Initialize()
	. = ..()
	create_reagents(reagent_amount, OPENCONTAINER)

/obj/item/ammo_casing/shotgun/dart/attackby()
	return

/obj/item/ammo_casing/shotgun/dart/noreact
	name = "cryostasis shotgun dart"
	desc = "A dart for use in shotguns. Uses technology similar to cryostasis beakers to keep internal reagents from reacting. Can be injected with up to 10 units of any chemical."
	icon_state = "cnrshell"
	reagent_amount = 10
	fire_power = CASING_POWER_SHOTGUN * CASING_POWER_MOD_MATCH

/obj/item/ammo_casing/shotgun/dart/noreact/Initialize()
	. = ..()
	ENABLE_BITFIELD(reagents.reagents_holder_flags, NO_REACT)

/obj/item/ammo_casing/shotgun/dart/bioterror
	desc = "A shotgun dart filled with an obscene amount of lethal reagents. Heaven help whoever is shot with this."
	projectile_type = /obj/item/projectile/bullet/dart/piercing
	reagent_amount = 50
	fire_power = CASING_POWER_SHOTGUN * CASING_POWER_MOD_MATCH

/obj/item/ammo_casing/shotgun/dart/bioterror/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/toxin/amanitin, 12) //for a nasty surprise after you get shot and somehow escape and don't think to quickly purge, and even shock those who are loaded up on purging agents
	reagents.add_reagent(/datum/reagent/toxin/chloralhydrate, 6)
	reagents.add_reagent(/datum/reagent/toxin/mutetoxin, 6) //;HELPIES OPS IN MAINT
	reagents.add_reagent(/datum/reagent/impedrezene, 6)
	reagents.add_reagent(/datum/reagent/toxin/acid/fluacid, 5) //this and the acid equal about 25ish burn, not counting the minute toxin damage dealt by their metabolism, this makes each dart about as lethal as a stechkin shot in upfront damage
	reagents.add_reagent(/datum/reagent/toxin/acid, 5)
	reagents.add_reagent(/datum/reagent/consumable/frostoil, 10) //tempgun slowdown goes both ways and adds to the burn

/obj/item/ammo_casing/shotgun/incapacitate
	name = "custom incapacitating shot"
	desc = "A shotgun casing filled with... something. used to incapacitate targets."
	icon_state = "bountyshell"
	projectile_type = /obj/item/projectile/bullet/pellet/shotgun_incapacitate
	pellets = 12//double the pellets, but half the stun power of each, which makes this best for just dumping right in someone's face.
	variance = 25
	custom_materials = list(/datum/material/iron=4000)
	fire_power = CASING_POWER_SHOTGUN * CASING_POWER_MOD_MATCH

/obj/item/ammo_casing/shotgun/magnumshot
	name = "12 gauge magnum buckshot shell"
	desc = "A 12 gauge magnum buckshot shell."
	icon_state = "magshell"
	projectile_type = /obj/item/projectile/bullet/pellet/magnum_buckshot
	pellets = 7
	variance = 15
	fire_power = CASING_POWER_SHOTGUN * CASING_POWER_MOD_MATCH

/obj/item/ammo_casing/shotgun/trainshot
	name = "12 gauge trainshot shell"
	desc = "It's a 12-gauge, 3-pellet tungsten trainshot shotgun shell. Sometimes referred to as the tungsten trinity."
	icon_state = "magshell"
	projectile_type = /obj/item/projectile/bullet/pellet/trainshot
	pellets = 3
	variance = 15
	fire_power = CASING_POWER_SHOTGUN * CASING_POWER_MOD_MATCH

// 40mm (Grenade Launcher)
/obj/item/ammo_casing/a40mm
	name = "40mm HE shell"
	desc = "A cased high explosive grenade that can only be activated once fired out of a grenade launcher."
	caliber = CALIBER_SHOTGUN
	icon_state = "40mmHE"
	projectile_type = /obj/item/projectile/bullet/a40mm/he
	material_class = BULLET_IS_GRENADE
	casing_quality = BULLET_IS_SURPLUS
	custom_materials = list(
		/datum/material/iron = MATS_GRENADE_CASING + MATS_GRENADE_BULLET,
		/datum/material/blackpowder = MATS_GRENADE_POWDER)
	fire_power = CASING_POWER_GRENADE * CASING_POWER_MOD_MATCH
	sound_properties = CSP_40MM

/obj/item/ammo_casing/a40mm/hedp
	name = "40mm HEDP shell"
	desc = "A cased dual purpose grenade that can only be activated once fired out of a grenade launcher."
	caliber = CALIBER_SHOTGUN
	icon_state = "40mmHEDP"
	projectile_type = /obj/item/projectile/bullet/a40mm/hedp

/obj/item/ammo_casing/a40mm/buck
	name = "40mm buckshot shell"
	desc = "A large caliber buckshot round, designed to be fired out of a grenade launcher."
	caliber = CALIBER_SHOTGUN
	icon_state = "40mmbuck"
	projectile_type = /obj/item/projectile/bullet/pellet/shotgun_buckshot
	custom_materials = list(
		/datum/material/iron = MATS_GRENADE_CASING + MATS_SHOTGUN_BULLET,
		/datum/material/blackpowder = MATS_SHOTGUN_POWDER)
	pellets = 12 //96 damage. can't complain
	variance = SHOTGUN_SPREAD_BASE

// big ass rockets
/obj/item/ammo_casing/caseless/rocket
	name = "\improper Low Yield Rocket"
	desc = "The PM-9LHE is an 84mm low-yield High Explosive rocket. Fire at people and pray."
	caliber = CALIBER_SHOTGUN
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "m6a1"
	projectile_type = /obj/item/projectile/bullet/a84mm_he
	is_pickable = FALSE
	custom_materials = list(
		/datum/material/iron = MATS_ROCKET_CASING + MATS_ROCKET_BULLET,
		/datum/material/blackpowder = MATS_ROCKET_POWDER) // great source of powder
	sound_properties = CSP_MISC

/obj/item/ammo_casing/caseless/rocket/hedp
	name = "\improper High Explosive Dual Purpose Rocket"
	desc = "The PM-9HEDP is an 84mm High Explosive Dual Purpose rocket. Pointy end toward mechs."
	icon_state = "og7v"
	projectile_type = /obj/item/projectile/bullet/a84mm

/obj/item/ammo_casing/caseless/rocket/incendiary
	name = "\improper Incendiary Rocket"
	desc = "The PM-9 I is an 84mm incendiary rocket. Fire with care."
	icon_state = "rocketshell"
	projectile_type = /obj/item/projectile/bullet/a84mm_incend

/obj/item/ammo_casing/caseless/rocket/chem
	name = "\improper Chemical Rocket"
	desc = "The PM-9C is an 84mm chemical dispersement rocket. Fire with great shame."
	icon_state = "pg7v"
	projectile_type = /obj/item/projectile/bullet/a84mm_chem

/obj/item/ammo_casing/caseless/rocket/big
	name = "\improper High Yield HE Rocket"
	desc = " The PM-9 HHE is like the low-yield HE rocket, but bigger."
	icon_state = "m6a1"
	projectile_type = /obj/item/projectile/bullet/a84mm_he_big

/obj/item/ammo_casing/caseless/rocket/big/Initialize(mapload, set_snowflake_id)
	. = ..()
	transform *= 1.5
	special_transform = transform

// BETA STUFF // Obsolete
/obj/item/ammo_casing/shotgun/buckshot/test
	name = "buckshot shell"
	desc = "A 12 gauge buckshot shell."
	icon_state = "gshell"
	projectile_type = /obj/item/projectile/bullet/pellet/shotgun_buckshot/test
	pellets = 6
	variance = 18
	fire_power = CASING_POWER_SHOTGUN * CASING_POWER_MOD_MATCH

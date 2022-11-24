/* not a caves of qud ripoff
technically mad shitcode for rn
plan is to ultimately have it pull from cargo export datum for how valuable stuff is
GLOBAL_LIST_INIT(sacredwellitems_components, typecacheof(list(/obj/item/advanced_crafting_components/flux,
	/obj/item/advanced_crafting_components/lenses,
	/obj/item/advanced_crafting_components/conductors,
	/obj/item/advanced_crafting_components/receiver,
	/obj/item/advanced_crafting_components/assembly,
	/obj/item/advanced_crafting_components/alloys)))
*/

// global lists

GLOBAL_LIST_INIT(sacredwellitems_components, typecacheof(list(/obj/item/stock_parts,
			/obj/item/gun_upgrade/scope/watchman,
			/obj/item/gun_upgrade/trigger/raidertrigger,
			/obj/item/tool_upgrade/productivity/ergonomic_grip,
			/obj/item/tool_upgrade/refinement/ported_barrel,
			/obj/item/tool_upgrade/refinement/stabilized_grip,
			/obj/item/tool_upgrade/refinement/laserguide,
			/obj/item/tool_upgrade/productivity/booster,
			/obj/item/tool_upgrade/productivity/red_paint)))

GLOBAL_LIST_INIT(sacredwellitems_misc, typecacheof(list(/obj/item/stock_parts/chem_cartridge/,
			/obj/item/stock_parts/cell/ammo)))

GLOBAL_LIST_INIT(sacredwellitems_low, typecacheof(list(/obj/item/gun/energy/laser/pistol,
	/obj/item/stock_parts/cell/ammo,
	/obj/item/gun/ballistic,
	/obj/item/stock_parts/cell/ammo/mfc
	)))

GLOBAL_LIST_INIT(sacredwellitems_mid, typecacheof(list(/obj/item/gun/energy/laser,
	/obj/item/advanced_crafting_components,
	/obj/item/gun/ballistic/automatic/service)))

GLOBAL_LIST_INIT(sacredwellitems_high, typecacheof(list(/obj/item/gun/energy/laser/plasma,
/obj/item/clothing/suit/armor/power_armor,
/obj/item/clothing/head/helmet/f13/power_armor)))


// objects

/obj/effect/spawner/lootdrop/f13/sacredwell
	lootcount = 1
	lootdoubles = FALSE
	loot = list(/obj/item/clothing/suit/armor/heavy/salvaged_pa/t45b/tribal,
				/obj/item/gun/energy/laser/wattz/sacredpistol,
				/obj/item/gun/energy/laser/wattz/sacred,
				/obj/item/gun/energy/laser/wattz2k/extended/blessed,
				/obj/item/gun/ballistic/shotgun/automatic/combat/auto5/sacred)

// sacred items

/obj/item/gun/energy/laser/wattz/sacredpistol
	name = "Blessed AEP"
	desc = "Scorch the darkness of the Old World away. It is wrapped in ropes and braids, and has beads attached to it. A broken multicolored crystal at the front sends two weak beams skewing outwards. A rainbow matched in its beauty only by its terror."
	icon_state = "bleAEP7"

	slowdown = GUN_SLOWDOWN_PISTOL_LIGHT
	force = GUN_MELEE_FORCE_PISTOL_LIGHT
	weapon_weight = GUN_ONE_HAND_AKIMBO
	draw_time = GUN_DRAW_NORMAL
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	ammo_type = list(/obj/item/ammo_casing/energy/laser/scatter/tribeam/hitscan)
	damage_multiplier = GUN_LESS_DAMAGE_T4 //still ends up doing more at pb
	charge_cost_multiplier = 1.5
	burst_size = 1

// normal but fancy sprite
/obj/item/gun/energy/laser/wattz/sacred
	name = "Blessed Wattz 1000"
	desc = "A hilt long worn-off made of bone, molded for the hand of those who respect the weapon it carries. A complex tapestry of peoples used this weapon, carving their stories into the grip. Life is written on death. And so the cycle goes."
	icon_state = "bwattz1000"


// sniper, infinite ammo, slow firing, lower dmg than usual
/obj/item/gun/energy/laser/wattz2k/extended/blessed
	name = "Blessed Wattz 2000e"
	desc = "What an ancient weapon, decorated in the highest and greatest honors one can give. Skulls, rags, cloth- and yet the purpose does not change. The act of killing is changed by its implements, not appearance. And implements this weapon has aplenty. The well never seems to run dry."
	selfcharge = 1
	can_remove = 0
	can_charge = 0
	can_scope = FALSE
	icon_state = "bwattz2k_ext"
	damage_multiplier = GUN_LESS_DAMAGE_T2
	charge_cost_multiplier = 1.5

/obj/item/gun/ballistic/shotgun/automatic/combat/auto5/sacred
	name = "Blessed Auto 5"
	desc = "A foregrip hides an internal tube beneath a sawed chrome barrel. Every shot screams an ode of violence and carbonized powder to the wind. The spread is wide, but harsh."
	icon_state = "sacredshotty"
	slowdown = GUN_SLOWDOWN_SHOTGUN_FIXED








/obj/structure/sacredwell
	name = "sacred well"
	density = 1
	anchored = 1
	var/sacredmeter = 0
	var/sacredmeter_max = 1000 //how much charge it needs before it does the thing
	var/cooling = 0
	desc = "A deep well that hums and thrums with power and unknown energies. Despite the fact it is hot to the touch, the geiger counter stays quiet. This is where the mistakes of the old world go to be cleansed. And with enough sacrifice comes gifts."
	icon = 'icons/obj/Ritas.dmi'
	icon_state = "wellwheel-filling"

/obj/structure/sacredwell/attackby(obj/item/W, mob/user)

	if(src.cooling <= 0)

		if(W.type in GLOB.sacredwellitems_high)
			qdel(W)
			sacredmeter += 200
			update_meter()
			return

		if(W.type in GLOB.sacredwellitems_mid)
			qdel(W)
			sacredmeter += 150
			update_meter()
			return

		else if(W.type in GLOB.sacredwellitems_low)
			qdel(W)
			sacredmeter += 100
			update_meter()
			return

		else if(W.type in GLOB.sacredwellitems_misc)
			qdel(W)
			sacredmeter += 50
			update_meter()
			return

		else if(W.type in GLOB.sacredwellitems_components)
			qdel(W)
			sacredmeter += 25
			update_meter()
			return

		else
			to_chat(user, span_danger("This is not appropriate for the well."))
			return

	else
		to_chat(user, span_danger("The spirits rest. The well is quiet."))
		return



/obj/structure/sacredwell/proc/update_meter() //checks if sacredmeter is above max, if it is, minuses sacredmeter_max from current amnt to simulate 'overflow'

	if(src.sacredmeter < src.sacredmeter_max)

		visible_message(span_notice("The well thrums with power!"))
		playsound(src, 'sound/mecha/mech_shield_drop.ogg', 80, 0, -1)
		desc = "A deep well that hums and thrums with power and unknown energies. Despite the fact it is hot to the touch, the geiger counter stays quiet. This is where the mistakes of the old world go to be cleansed. And with enough sacrifice comes gifts.<br><span class='notice'> The well has [sacredmeter] out of [sacredmeter_max] charge.</span>"
		return


	else if(src.sacredmeter >= src.sacredmeter_max)
		visible_message(span_notice("The well creaks and hums- and out spews forth an item, blessed by the spirits. It is sanctified and safe."))
		sacredmeter -= src.sacredmeter_max
		playsound(src, 'sound/mecha/mech_shield_raise.ogg', 80, 0, -1)
		new /obj/effect/spawner/lootdrop/f13/sacredwell(src.loc)
		dontspam()
		return

	return


/obj/structure/sacredwell/proc/dontspam() //might need to fiddle w/ this......

	desc = "A deep well that hums and thrums with power and unknown energies. Despite the fact it is hot to the touch, the geiger counter stays quiet. This is where the mistakes of the old world go to be cleansed. And with enough sacrifice comes gifts.<br><span class='notice'> The well is currently resting.</span>"
	cooling = 1
	sleep(1000)
	cooling = 0
	desc = "A deep well that hums and thrums with power and unknown energies. Despite the fact it is hot to the touch, the geiger counter stays quiet. This is where the mistakes of the old world go to be cleansed. And with enough sacrifice comes gifts.<br><span class='notice'> The well has [sacredmeter] out of [sacredmeter_max] charge.</span>"
	return






















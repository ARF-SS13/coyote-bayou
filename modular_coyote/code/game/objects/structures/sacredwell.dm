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

#define WELL_COMPONENTS "sacredwellitems_components"
#define WELL_MISC "sacredwellitems_misc"
#define WELL_LOW "sacredwellitems_low"
#define WELL_MID "sacredwellitems_mid"
#define WELL_HIGH "sacredwellitems_high"

GLOBAL_LIST_INIT(sacred_well_prices, list(
	WELL_HIGH = 200,
	WELL_MID = 150,
	WELL_LOW = 100,
	WELL_MISC = 50,
	WELL_COMPONENTS = 25,
))

GLOBAL_LIST_EMPTY(sacred_well_items)


// objects

/obj/effect/spawner/lootdrop/f13/sacredwell
	lootcount = 1
	lootdoubles = FALSE
	loot = list(/obj/item/clothing/suit/armor/heavy/salvaged_pa/t45b/tribal,
				/obj/item/gun/energy/laser/wattz/sacredpistol,
				/obj/item/gun/energy/laser/wattz/sacred,
				/obj/item/gun/energy/laser/wattz2k/extended/blessed,
				/obj/item/gun/ballistic/shotgun/automatic/combat/auto5/sacred,
				/obj/item/gun/ballistic/automatic/smg/tommygun/whitelegs,
				/obj/item/gun/ballistic/bow/composite/masterwork,
				/obj/item/gun/ballistic/bow/longbow,
				/obj/item/clothing/suit/armor/medium/tribal/tribe_heavy_armor,
				/obj/item/clothing/suit/armor/light/tribal/simple,
				/obj/item/scrying,
				/obj/item/clothing/suit/hooded/cloak)

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

///// WW         WW EEEEEEE LL 	   LL
///// WW         WW EE      LL     LL
///// WW    WW   WW EEEEE   LL     LL
/////   WW  WW  WW  EE      LL     LL
/////    WW WW WW   EE      LL     LL
/////     WW  WW    EEEEEEE LLLLLL LLLLLL

/obj/structure/sacredwell
	name = "sacred well"
	desc = "A deep well that hums and thrums with power and unknown energies."
	icon = 'icons/obj/f13vending.dmi'
	icon_state = "sacred_well"
	density = 1
	anchored = 1
	var/sacredmeter = 0
	var/sacredmeter_max = 1000 //how much charge it needs before it does the thing
	var/cooling = FALSE
	var/debug = FALSE

/obj/structure/sacredwell/Initialize()
	. = ..()
	if(!LAZYLEN(GLOB.sacred_well_items)) /// Stop. Fucking. Erroring.
		init_well_shit()

/obj/structure/sacredwell/proc/init_well_shit()
	var/list/high = typecacheof(list(
		/obj/item/gun/energy/laser/plasma,
		/obj/item/clothing/suit/armor/power_armor,
		/obj/item/clothing/head/helmet/f13/power_armor))
	var/list/mid = typecacheof(list(
		/obj/item/gun/energy/laser,
		/obj/item/gun/ballistic/automatic/service))
	var/list/low = typecacheof(list(
		/obj/item/gun/energy/laser/pistol,
		/obj/item/stock_parts/cell/ammo,
		/obj/item/gun/ballistic))
	var/list/misc = typecacheof(list(
		/obj/item/stock_parts/chem_cartridge,
		/obj/item/stock_parts/cell))
	var/list/comp = typecacheof(list(
		/obj/item/advanced_crafting_components,
		/obj/item/stock_parts))
	GLOB.sacred_well_items[WELL_HIGH] = high
	GLOB.sacred_well_items[WELL_MID] = mid
	GLOB.sacred_well_items[WELL_LOW] = low
	GLOB.sacred_well_items[WELL_MISC] = misc
	GLOB.sacred_well_items[WELL_COMPONENTS] = comp
	///fuck

/obj/structure/sacredwell/examine()
	. = ..()
	if(cooling)
		. += "This is where the mistakes of the old world go to be cleansed. And with enough sacrifice comes gifts."
		. += span_alert("The well feels cold to the touch, and air currents around it seem quite still. It seems to be resting.")
	else
		. += "Despite the fact it is hot to the touch, the geiger counter stays quiet. Warm air currents swirl about the entrance."
		. += span_notice("Despite the fact it is hot to the touch, the geiger counter stays quiet. This is where the mistakes of the old world go to be cleansed. And with enough sacrifice comes gifts.")
		switch(sacredmeter)
			if(-INFINITY to 50)
				. += span_notice("The interior is dark and seems to go on forever.")
			if(50 to 100)
				. += span_notice("The interior is dark and seems to go on forever. Deep down, you can make out a faint orange glow.")
			if(100 to 200)
				. += span_notice("The interior has taken on a faint orange glow, its source unseen. A dull warmth radiates from the well.")
			if(200 to 300)
				. += span_notice("The interior has taken on a faint orange glow, the cracks between its bricks joining in. The warmth is palpable.")
			if(300 to 400)
				. += span_notice("Deep in the well, beneath the faint orange glow, you can make out a vague, cloudy shape. The warmth is palpable.")
			if(400 to 500)
				. += span_notice("Bright orange sparks dance about in the cloudy depths of the well, a vague, shifting form taking shape. The bricks are hot to the touch.")
			if(500 to 600)
				. += span_notice("Bright orange sparks leap about in the cloudy depths, its walls bending in every direction around an unrecognizable shape. Moisture around the rim starts to sizzle.")
			if(600 to 700)
				. += span_notice("A bright orange light fills the well, its walls bending in every direction around an unrecognizable shape. Moisture around the rim starts to sizzle.")
			if(700 to 800)
				. += span_notice("The bright orange light within the well seems to boil, odd shimmering shapes forming and dissipating in the depths. The shape within bends, passing through itself, and then back again. The heat is unbearable.") 
			if(800 to 900)
				. += span_notice("A vague clarity forms within the bright orange light, shapes both familiar and alien forming and dissipating in the depths. The shape has settled on a form, but you can't quite make it out. The heat is unbearable.")
			if(900 to INFINITY)
				. += span_notice("Bright orange forms flash into existence and then dissipate, landscapes of an odd familiarity, not unlike a dream you can't quite remember. The shape is clear now, you know what it is, yet you can't seem to put it into words. The heat and light are unbearable.")

/obj/structure/sacredwell/attackby(obj/item/W, mob/user)
	if(cooling)
		still_cooling(W, user)
		return
	if(!try_well(W, user))
		reject_well(W, user)

/obj/structure/sacredwell/proc/try_well(obj/item/W, mob/user)
	if(!user || !isitem(W))
		return
	var/wellability = 0
	for(var/value in GLOB.sacred_well_items)
		if(is_type_in_typecache(W.type, GLOB.sacred_well_items[value]))
			wellability = GLOB.sacred_well_prices[value]
			if(debug)
				say("wellability: [wellability], found in value [value]. neat")
			break
	if(!wellability)
		wellability = SEND_SIGNAL(W, COMSIG_ITEM_WELLABLE, user)
		if(!wellability)
			return
	return well(W, user, wellability)

/obj/structure/sacredwell/proc/well(obj/item/W, mob/user, wellability)
	if(!user || !W || !wellability)
		return
	sacredmeter += wellability
	qdel(W)
	if(debug)
		say("wellability: [wellability], sacredmeter: [sacredmeter]")
	. = TRUE
	visible_message(span_notice("[W] is enveloped by a pale orange glow as it falls into the depths! \The [src] emits a low, pleased hum."))
	if(sacredmeter < sacredmeter_max)
		switch(sacredmeter)
			if(-INFINITY to 250)
				set_light(1, 1, "#ffd000")
			if(250 to 500)
				set_light(3, 3, "#ffde4c")
			if(500 to 750)
				set_light(5, 5, "#fee886")
			if(750 to INFINITY)
				set_light(7, 10, "#ffff00")
		playsound(src, 'sound/effects/well_accept.ogg', 70, TRUE)
		return
	visible_message(span_notice("The orange blaze within \the [src] collapses into into itself, and in its place, something rises from the resulting darkness. It is blessed by the spirits, sanctified and safe."))
	sacredmeter -= sacredmeter_max
	playsound(src, 'sound/effects/well_good.ogg', 70, TRUE)
	new /obj/effect/spawner/lootdrop/f13/sacredwell(get_turf(src))
	start_cooldown()

/obj/structure/sacredwell/proc/reject_well(obj/item/W, mob/user)
	playsound(src, 'sound/effects/well_whine.ogg', 70, TRUE)
	audible_message("[src] lets out a whiny hum.")
	to_chat(user, span_alert("A wall of force and heat prevents [W] from entering \the [src]."))

/obj/structure/sacredwell/proc/still_cooling(obj/item/W, mob/user) //might need to fiddle w/ this......
	playsound(src, 'sound/effects/well_tired.ogg', 70, TRUE)
	audible_message("[src] lets out a tired hum.")
	to_chat(user, span_alert("\The [src] pushes back on \the [W]."))

/obj/structure/sacredwell/proc/start_cooldown() //might need to fiddle w/ this......
	cooling = TRUE
	if(debug)
		say("cooldown started!!")
	set_light(1, -1, "#f9ff48")
	addtimer(CALLBACK(src,PROC_REF(end_cooldown)), 1.5 MINUTES)

/obj/structure/sacredwell/proc/end_cooldown() //might need to fiddle w/ this......
	if(debug)
		say("cooldown ended!!")
	cooling = FALSE
	playsound(src, 'sound/effects/well_wake.ogg', 70, TRUE)
	audible_message("[src] lets out a well-rested hum.")


/obj/item/storage/debug/debug_well
	name = "Bag of Debug Well Stuff"
	desc = "A cool bag of well stuff!"

/obj/item/storage/debug/debug_well/PopulateContents()
	. = ..()
	new /obj/item/stock_parts/capacitor/quadratic(src)
	new /obj/item/stock_parts/capacitor/quadratic(src)
	new /obj/item/stock_parts/capacitor/quadratic(src)
	new /obj/item/stock_parts/capacitor/quadratic(src)
	new /obj/item/stock_parts/capacitor/quadratic(src)
	new /obj/item/stock_parts/capacitor/quadratic(src)
	new /obj/item/stock_parts/cell/ammo/ec(src)
	new /obj/item/stock_parts/cell/ammo/ec(src)
	new /obj/item/stock_parts/cell/ammo/ec(src)
	new /obj/item/stock_parts/cell/ammo/ec(src)
	new /obj/item/stock_parts/cell/ammo/ec(src)
	new /obj/item/stock_parts/cell/ammo/ec(src)
	new /obj/item/stock_parts/cell/ammo/ec(src)
	new /obj/item/gun/ballistic/automatic/service/carbine(src)
	new /obj/item/gun/ballistic/automatic/service/carbine(src)
	new /obj/item/gun/ballistic/automatic/service/carbine(src)
	new /obj/item/gun/ballistic/automatic/service/carbine(src)
	new /obj/item/gun/ballistic/automatic/service/carbine(src)
	new /obj/item/gun/ballistic/automatic/service/carbine(src)
	new /obj/item/clothing/head/helmet/f13/power_armor(src)
	new /obj/item/clothing/head/helmet/f13/power_armor(src)
	new /obj/item/clothing/head/helmet/f13/power_armor(src)
	new /obj/item/clothing/head/helmet/f13/power_armor(src)
	new /obj/item/clothing/head/helmet/f13/power_armor(src)



















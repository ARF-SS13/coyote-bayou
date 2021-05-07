/obj/item/gun/energy/laser
	name = "laser gun"
	desc = "A basic energy-based laser gun that fires concentrated beams of light which pass through glass and thin metal."
	icon_state = "laser"
	item_state = "laser"
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(/datum/material/iron=2000)
	ammo_type = list(/obj/item/ammo_casing/energy/lasergun)
	ammo_x_offset = 1
	shaded_charge = 1
	var/select = 1

/obj/item/gun/energy/laser/practice
	name = "practice laser gun"
	icon_state = "laser-p"
	desc = "A modified version of the basic laser gun, this one fires less concentrated energy bolts designed for target practice."
	ammo_type = list(/obj/item/ammo_casing/energy/laser/practice)
	clumsy_check = 0
	item_flags = NONE

/obj/item/gun/energy/laser/practice/hyperburst
	name = "toy hyper-burst launcher"
	desc = "A toy laser with a unique beam shaping lens that projects harmless bolts capable of going through objects. Compatible with existing laser tag systems."
	ammo_type = list(/obj/item/ammo_casing/energy/laser/magtag)
	icon_state = "toyburst"
	obj_flags = NONE
	fire_delay = 40
	w_class = WEIGHT_CLASS_HUGE
	weapon_weight = WEAPON_HEAVY
	selfcharge = EGUN_SELFCHARGE
	charge_delay = 2
	recoil = 2
	cell_type = /obj/item/stock_parts/cell/toymagburst

/obj/item/gun/energy/laser/retro
	name ="retro laser gun"
	icon_state = "retro"
	desc = "An older model of the basic lasergun, no longer used by Nanotrasen's private security or military forces. Nevertheless, it is still quite deadly and easy to maintain, making it a favorite amongst pirates and other outlaws."
	ammo_x_offset = 3

/obj/item/gun/energy/laser/retro/old
	name ="laser gun"
	icon_state = "retro"
	desc = "First generation lasergun, developed by Nanotrasen. Suffers from ammo issues but its unique ability to recharge its ammo without the need of a magazine helps compensate. You really hope someone has developed a better lasergun while you were in cryo."
	ammo_type = list(/obj/item/ammo_casing/energy/lasergun/old)
	ammo_x_offset = 3

/obj/item/gun/energy/laser/hellgun
	name ="hellfire laser gun"
	desc = "A relic of a weapon, built before NT began installing regulators on its laser weaponry. This pattern of laser gun became infamous for the gruesome burn wounds it caused, and was quietly discontinued once it began to affect NT's reputation."
	icon_state = "hellgun"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/hellfire)

/obj/item/gun/energy/laser/captain
	name = "antique laser gun"
	icon_state = "caplaser"
	item_state = "caplaser"
	desc = "This is an antique laser gun. All craftsmanship is of the highest quality. It is decorated with assistant leather and chrome. The object menaces with spikes of energy. On the item is an image of Space Station 13. The station is exploding."
	force = 10
	ammo_x_offset = 3
	selfcharge = EGUN_SELFCHARGE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/item/gun/energy/laser/carbine
	name = "laser carbine"
	desc = "A ruggedized laser carbine featuring much higher capacity and improved handling when compared to a normal laser gun."
	icon_state = "lasernew"
	item_state = "lasernew"
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM
	inaccuracy_modifier = 0.7
	force = 10
	throwforce = 10
	cell_type = /obj/item/stock_parts/cell/lascarbine
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/gun/energy/laser/carbine/nopin
	pin = null

/obj/item/gun/energy/laser/captain/scattershot
	name = "scatter shot laser rifle"
	icon_state = "lasercannon"
	item_state = "laser"
	desc = "An industrial-grade heavy-duty laser rifle with a modified laser lens to scatter its shot into multiple smaller lasers. The inner-core can self-charge for theoretically infinite use."
	ammo_type = list(/obj/item/ammo_casing/energy/laser/scatter, /obj/item/ammo_casing/energy/laser)

/obj/item/gun/energy/laser/cyborg
	can_charge = FALSE
	desc = "An energy-based laser gun that draws power from the cyborg's internal energy cell directly. So this is what freedom looks like?"
	icon = 'icons/obj/items_cyborg.dmi'
	icon_state = "laser_cyborg"
	selfcharge = EGUN_SELFCHARGE_BORG
	cell_type = /obj/item/stock_parts/cell/secborg
	charge_delay = 3

/obj/item/gun/energy/laser/cyborg/emp_act()
	return

/obj/item/gun/energy/laser/cyborg/mean
	use_cyborg_cell = TRUE
	selfcharge = EGUN_NO_SELFCHARGE

/obj/item/gun/energy/laser/scatter
	name = "scatter laser gun"
	desc = "A laser gun equipped with a refraction kit that spreads bolts."
	ammo_type = list(/obj/item/ammo_casing/energy/laser/scatter, /obj/item/ammo_casing/energy/laser)

/obj/item/gun/energy/laser/scatter/shotty
	name = "energy shotgun"
	icon = 'icons/obj/guns/projectile.dmi'
	icon_state = "cshotgun"
	item_state = "shotgun"
	desc = "A combat shotgun gutted and refitted with an internal laser system. Can switch between taser and scattered disabler shots."
	shaded_charge = 0
	pin = /obj/item/firing_pin/implant/mindshield
	ammo_type = list(/obj/item/ammo_casing/energy/laser/scatter/disabler, /obj/item/ammo_casing/energy/electrode)

///Laser Cannon

/obj/item/gun/energy/lasercannon
	name = "accelerator laser cannon"
	desc = "An advanced laser cannon that does more damage the farther away the target is."
	icon_state = "lasercannon"
	item_state = "laser"
	w_class = WEIGHT_CLASS_BULKY
	force = 10
	flags_1 =  CONDUCT_1
	slot_flags = ITEM_SLOT_BACK
	ammo_type = list(/obj/item/ammo_casing/energy/laser/accelerator)
	pin = null
	ammo_x_offset = 3

/obj/item/ammo_casing/energy/laser/accelerator
	projectile_type = /obj/item/projectile/beam/laser/accelerator
	select_name = "accelerator"
	fire_sound = 'sound/weapons/lasercannonfire.ogg'

/obj/item/projectile/beam/laser/accelerator
	name = "accelerator laser"
	icon_state = "scatterlaser"
	range = 255
	damage = 6

/obj/item/projectile/beam/laser/accelerator/Range()
	..()
	damage += 7
	transform *= 1 + ((damage/7) * 0.2)//20% larger per tile

/obj/item/gun/energy/xray
	name = "\improper X-ray laser gun"
	desc = "A high-power laser gun capable of expelling concentrated X-ray blasts that pass through multiple soft targets and heavier materials."
	icon_state = "xray"
	item_state = null
	ammo_type = list(/obj/item/ammo_casing/energy/xray)
	pin = null
	ammo_x_offset = 3

////////Laser Tag////////////////////

/obj/item/gun/energy/laser/bluetag
	name = "laser tag gun"
	icon_state = "bluetag"
	desc = "A retro laser gun modified to fire harmless blue beams of light. Sound effects included!"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/bluetag)
	item_flags = NONE
	clumsy_check = FALSE
	pin = /obj/item/firing_pin/tag/blue
	ammo_x_offset = 2
	selfcharge = EGUN_SELFCHARGE

/obj/item/gun/energy/laser/bluetag/hitscan
	ammo_type = list(/obj/item/ammo_casing/energy/laser/bluetag/hitscan)

/obj/item/gun/energy/laser/redtag
	name = "laser tag gun"
	icon_state = "redtag"
	desc = "A retro laser gun modified to fire harmless beams red of light. Sound effects included!"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/redtag)
	item_flags = NONE
	clumsy_check = FALSE
	pin = /obj/item/firing_pin/tag/red
	ammo_x_offset = 2
	selfcharge = EGUN_SELFCHARGE

/obj/item/gun/energy/laser/redtag/hitscan
	ammo_type = list(/obj/item/ammo_casing/energy/laser/redtag/hitscan)

/obj/item/gun/energy/laser/redtag/hitscan/chaplain
	name = "\improper holy lasrifle"
	desc = "A lasrifle from the old Imperium. This one seems to be blessed by techpriests."
	icon_state = "LaserAK"
	item_state = null
	force = 14
	pin = /obj/item/firing_pin/holy
	icon = 'modular_citadel/icons/obj/guns/VGguns.dmi'
	ammo_x_offset = 4
	ammo_type = list(/obj/item/ammo_casing/energy/laser/redtag/hitscan/holy)
	lefthand_file = 'modular_citadel/icons/mob/citadel/guns_lefthand.dmi'
	righthand_file = 'modular_citadel/icons/mob/citadel/guns_righthand.dmi'
	var/chaplain_spawnable = TRUE
	total_mass = TOTAL_MASS_MEDIEVAL_WEAPON
	throw_speed = 3
	throw_range = 4
	throwforce = 10
	obj_flags = UNIQUE_RENAME

/obj/item/gun/energy/laser/redtag/hitscan/chaplain/Initialize()
	. = ..()
	AddComponent(/datum/component/anti_magic, TRUE, TRUE, FALSE, null, null, FALSE)

/obj/item/gun/energy/laser/redtag/hitscan/chaplain/handle_suicide(mob/living/carbon/human/user, mob/living/carbon/human/target, params, bypass_timer)
	if(!ishuman(user) || !ishuman(target))
		return

	if(on_cooldown())
		return

	if(user == target)
		target.visible_message("<span class='warning'>[user] sticks [src] in [user.p_their()] mouth, ready to pull the trigger...</span>", \
			"<span class='userdanger'>You stick [src] in your mouth, ready to pull the trigger...</span>")
	else
		target.visible_message("<span class='warning'>[user] points [src] at [target]'s head, ready to pull the trigger...</span>", \
			"<span class='userdanger'>[user] points [src] at your head, ready to pull the trigger...</span>")

	busy_action = TRUE

	if(!bypass_timer && (!do_mob(user, target, 120) || user.zone_selected != BODY_ZONE_PRECISE_MOUTH))
		if(user)
			if(user == target)
				user.visible_message("<span class='notice'>[user] decided not to shoot.</span>")
			else if(target && target.Adjacent(user))
				target.visible_message("<span class='notice'>[user] has decided to spare [target]</span>", "<span class='notice'>[user] has decided to spare your life!</span>")
		busy_action = FALSE
		return

	busy_action = FALSE

	target.visible_message("<span class='warning'>[user] pulls the trigger!</span>", "<span class='userdanger'>[user] pulls the trigger!</span>")

	playsound('sound/weapons/dink.ogg', 30, 1)

	if((iscultist(target)) || (is_servant_of_ratvar(target)))
		chambered.BB.damage *= 1500

	else if(chambered && chambered.BB)
		chambered.BB.damage *= 5

	process_fire(target, user, TRUE, params)

//Fallout

//six shots with the laser musket, stronger than a regular laser rifle,
//need electronics,
//a pipe rifle and a nuka cola bottle.
//Then you need makeshift energy cells, so empty MF cells. and electronics
//make the musket laser have like a 2 second delay after each shot

///obj/item/gun/energy/laser/musket
//	name = "Homemade Laser Musket"
//	desc = "A crudely made laser Musket, inneficient but powerful enough"
//	icon_state = "las_musket"
//	item_state = "las_musket"
//	fire_delay = 80
//	equipsound = 'sound/f13weapons/equipsounds/aer9equip.ogg'
//	ammo_type = list(/obj/item/ammo_casing/energy/laser/musket)
//	cell_type = /obj/item/stock_parts/cell/ammo/mfc
//	w_class = WEIGHT_CLASS_BULKY
//	weapon_weight = WEAPON_HEAVY

/obj/item/gun/energy/laser/attackby(obj/item/A, mob/user, params)
	. = ..()
	if(.)
		return
	if(istype(A, /obj/item/stock_parts/cell/ammo))
		var/obj/item/stock_parts/cell/ammo/AM = A
		if(istype(AM, cell_type))
			var/obj/item/stock_parts/cell/ammo/oldcell = cell
			if(user.transferItemToLoc(AM, src))
				cell = AM
				if(oldcell)
					to_chat(user, "<span class='notice'>You perform a tactical reload on \the [src], replacing the cell.</span>")
					oldcell.dropped()
					oldcell.forceMove(get_turf(src.loc))
					oldcell.update_icon()
				//else
				//	to_chat(user, "<span class='notice'>You insert the cell into \the [src].</span>")

				//playsound(src, 'sound/weapons/autoguninsert.ogg', 60, TRUE)
				//chamber_round()
				A.update_icon()
				update_icon()
				return 1
			else
				to_chat(user, "<span class='warning'>You cannot seem to get \the [src] out of your hands!</span>")

/obj/item/gun/energy/laser/aer9
	name = "\improper AER9 laser rifle"
	desc = "A sturdy and advanced military grade pre-war service laser rifle"
	icon_state = "laser"
	item_state = "laser-rifle9"
	can_scope = TRUE
	scope_state = "AEP7_scope"
	scope_x_offset = 12
	scope_y_offset = 20
	fire_delay = 3
	equipsound = 'sound/f13weapons/equipsounds/aer9equip.ogg'
	ammo_type = list(/obj/item/ammo_casing/energy/laser/lasgun)
	cell_type = /obj/item/stock_parts/cell/ammo/mfc
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY

/obj/item/gun/energy/laser/ultra_rifle
	name = "\improper Ultracite laser rifle"
	desc = "A sturdy and advanced military grade pre-war service laser rifle, now enhanced with ultracite"
	icon_state = "ultra_rifle"
	item_state = "laser-rifle9"
	zoomable = TRUE
	zoom_amt = 10
	zoom_out_amt = 13
	fire_delay = 3
	equipsound = 'sound/f13weapons/equipsounds/aer9equip.ogg'
	ammo_type = list(/obj/item/ammo_casing/energy/laser/lasgun)
	cell_type = /obj/item/stock_parts/cell/ammo/ultracite
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY

/obj/item/gun/energy/laser/pistol
	name = "\improper AEP7 laser pistol"
	desc = "A basic energy-based laser gun that fires concentrated beams of light."
	icon_state = "AEP7"
	item_state = "laser-pistol"
	equipsound = 'sound/f13weapons/equipsounds/aep7equip.ogg'
	w_class = WEIGHT_CLASS_NORMAL
	fire_delay = 2
	can_scope = TRUE
	scope_state = "AEP7_scope"
	scope_x_offset = 7
	scope_y_offset = 22
	ammo_type = list(/obj/item/ammo_casing/energy/laser/pistol)
	cell_type = /obj/item/stock_parts/cell/ammo/ec
	slot_flags = ITEM_SLOT_BELT

/obj/item/gun/energy/laser/ultra_pistol
	name = "\improper Ultracite laser pistol"
	desc = "An ultracite enhanced energy-based laser gun that fires concentrated beams of light."
	icon_state = "ultra_pistol"
	item_state = "laser-pistol"
	equipsound = 'sound/f13weapons/equipsounds/aep7equip.ogg'
	w_class = WEIGHT_CLASS_NORMAL
	fire_delay = 2
	scope_x_offset = 7
	scope_y_offset = 22
	ammo_type = list(/obj/item/ammo_casing/energy/laser/ultra_pistol)
	cell_type = /obj/item/stock_parts/cell/ammo/ec
	slot_flags = ITEM_SLOT_BELT

/obj/item/gun/energy/laser/solar
	name = "\improper Solar Scorcher"
	desc = "This modified AEP7 laser pistol takes its power from the sun, recharging slowly using stored solar energy. However, it cannot be recharged manually as a result."
	icon_state = "solarscorcher"
	item_state = "solarscorcher"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/solar) //30 damage, 20 AP
	cell_type = /obj/item/stock_parts/cell/ammo/ec //10 shots, self-charges
	equipsound = 'sound/f13weapons/equipsounds/aep7equip.ogg'
	can_charge = 0
	selfcharge = 1
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT

/obj/item/gun/energy/laser/scatter
	name = "tribeam laser rifle"
	desc = "A modified AER9 equipped with a refraction kit that spreads its bolts. It is usually only given to high-ranking soldiers within the Brotherhood, due to its level of technology, as well as its reputation of friendly fire."
	icon_state = "tribeam"
	item_state = "laser-rifle9"
	fire_delay = 3
	equipsound = 'sound/f13weapons/equipsounds/tribeamequip.ogg'
	ammo_type = list(/obj/item/ammo_casing/energy/laser/scatter)
	cell_type = /obj/item/stock_parts/cell/ammo/mfc
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY

/obj/item/gun/energy/laser/plasma
	name ="plasma rifle"
	item_state = "plasma"
	icon_state = "plasma"
	fire_delay = 4.5
	desc = "A top of line miniaturized plasma caster built by REPCONN in the wake of the Z43-521P failure. It is supperior to all previous rifles to enter service in the USCC."
	ammo_type = list(/obj/item/ammo_casing/energy/plasma)
	cell_type = /obj/item/stock_parts/cell/ammo/mfc
	equipsound = 'sound/f13weapons/equipsounds/plasequip.ogg'
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY

/obj/item/gun/energy/laser/plasma/carbine
	name ="plasma carbine"
	item_state = "plasma"
	icon_state = "plasmacarbine"
	desc = ""
	ammo_type = list(/obj/item/ammo_casing/energy/plasmacarbine)
	cell_type = /obj/item/stock_parts/cell/ammo/mfc
	burst_size = 2
	actions_types = list(/datum/action/item_action/toggle_firemode)
	equipsound = 'sound/f13weapons/equipsounds/plasequip.ogg'
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY

	can_scope = TRUE
	scope_state = "plasma_scope"
	scope_x_offset = 13
	scope_y_offset = 16


/obj/item/gun/energy/laser/proc/burst_select()
	var/mob/living/carbon/human/user = usr
	select = !select
	if(!select)
		disable_burst()
		to_chat(user, "<span class='notice'>You switch to semi-automatic.</span>")
	else
		enable_burst()
		to_chat(user, "<span class='notice'>You switch to [burst_size]-rnd burst.</span>")

/obj/item/gun/energy/laser/proc/enable_burst()
	burst_size = initial(burst_size)

/obj/item/gun/energy/laser/proc/disable_burst()
	burst_size = 1

/obj/item/gun/energy/laser/plasma/carbine/enable_burst()
	. = ..()
	spread = 15

/obj/item/gun/energy/laser/plasma/carbine/disable_burst()
	. = ..()
	spread = 0




/obj/item/gun/energy/laser/plasma/scatter
	name = "multiplas Rifle"
	item_state = "multiplas"
	icon_state = "multiplas"
	fire_delay = 3
	desc = "A modified A3-20 plasma caster built by REPCONN equipped with a multicasting kit that creates multiple weaker clots."
	equipsound = 'sound/f13weapons/equipsounds/plasequip.ogg'
	ammo_type = list(/obj/item/ammo_casing/energy/plasma/scatter)
	cell_type = /obj/item/stock_parts/cell/ammo/mfc
	weapon_weight = WEAPON_HEAVY


/obj/item/gun/energy/laser/plasma/pistol
	name ="plasma pistol"
	item_state = "plasma-pistol"
	icon_state = "plasma-pistol"
	desc = "A pistol-sized miniaturized plasma caster built by REPCONN. It fires heavy low penetration plasma clots."
	ammo_type = list(/obj/item/ammo_casing/energy/plasma/pistol)
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_LIGHT
	equipsound = 'sound/f13weapons/equipsounds/pistolplasequip.ogg'
	cell_type = /obj/item/stock_parts/cell/ammo/ec
	slot_flags = ITEM_SLOT_BELT


/obj/item/gun/energy/laser/plasma/glock
	name = "glock 86"
	item_state = "plasma-pistol"
	icon_state = "glock86"
	desc = "Glock 86 Plasma Pistol. Designed by the Gaston Glock artificial intelligence. Shoots a small bolt of superheated plasma. Powered by a small energy cell."
	ammo_type = list(/obj/item/ammo_casing/energy/plasma/pistol/glock)
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_LIGHT
	equipsound = 'sound/f13weapons/equipsounds/pistolplasequip.ogg'
	cell_type = /obj/item/stock_parts/cell/ammo/ec
	slot_flags = ITEM_SLOT_BELT


/obj/item/gun/energy/laser/plasma/glock/extended
	name ="glock 86a"
	item_state = "plasma-pistol"
	icon_state = "glock86a"
	desc = "This Glock 86 plasma pistol has had its magnetic housing chamber realigned to reduce the drain on its energy cell. Its efficiency has doubled, allowing it to fire more shots before the battery is expended."
	ammo_type = list(/obj/item/ammo_casing/energy/plasma/pistol/glock/extended)
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_LIGHT
	cell_type = /obj/item/stock_parts/cell/ammo/ec
	slot_flags = ITEM_SLOT_BELT

/obj/item/gun/energy/laser/wattz
	name = "Wattz 1000 laser pistol"
	desc = "A Wattz 1000 Laser Pistol. Civilian model, so the wattage is lower than military or police versions. Uses small energy cells."
	icon_state = "wattz1000"
	item_state = "laser-pistol"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/pistol/wattz)
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_LIGHT
	equipsound = 'sound/f13weapons/equipsounds/aep7equip.ogg'
	cell_type = /obj/item/stock_parts/cell/ammo/ec
	slot_flags = ITEM_SLOT_BELT

/obj/item/gun/energy/laser/wattz/magneto
	name = "Wattz 1000 magneto-laser pistol"
	desc = "This Wattz 1000 laser pistol has been upgraded with a magnetic field targeting system that tightens the laser emission, giving this pistol extra penetrating power."
	icon_state = "magnetowattz"
	item_state = "laser-pistol"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/pistol/wattz/magneto)
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_LIGHT
	cell_type = /obj/item/stock_parts/cell/ammo/ec
	slot_flags = ITEM_SLOT_BELT

/obj/item/gun/energy/laser/plasma/alien
	name = "alien blaster"
	item_state = "alienblaster"
	icon_state = "alienblaster"
	desc = "This weapon is unlike any other you've ever seen before, and appears to be made out of metals not usually found on Earth. It certainly packs a punch, though."
	ammo_type = list(/obj/item/ammo_casing/energy/plasma/alien)
	cell_type = /obj/item/stock_parts/cell/ammo/alien //unchargeable, but removable
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT

/obj/item/gun/energy/laser/rcw
	name = "laser RCW"
	desc = "A rapid-fire laser rifle modeled after the familiar \"Thompson\" SMG. It features high-accuracy burst fire that will whittle down targets in a matter of seconds."
	icon_state = "lasercw"
	item_state = "rcw"
	fire_delay = 3
	burst_size = 2

	equipsound = 'sound/f13weapons/equipsounds/RCWequip.ogg'
	ammo_type = list(/obj/item/ammo_casing/energy/laser/rcw)
	cell_type = /obj/item/stock_parts/cell/ammo/ecp
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY

/obj/item/gun/energy/laser/rcw/burst_select()
	var/mob/living/carbon/human/user = usr
	playsound(user, 'sound/weapons/empty.ogg', 100, 1)
	update_icon()
//	for(var/X in actions)
//		var/datum/action/A = X

/obj/item/gun/energy/laser/rcw/afterattack()
	. = ..()
//	empty_alarm()
	return

/obj/item/gun/energy/laser/laer
	name = "\improper LAER"
	desc = "The Laser Assister Energy Rifle is a powerful pre-war weapon developed just before the turn of the Great War. Due to its incredible rarity and unprecedented firepower, the weapon is coveted and nearly solely possesed by the Brotherhood of Steel; typically held by an Elder as a status symbol."
	icon_state = "laer"
	item_state = "laer"
	fire_delay = 3
	burst_size = 1
	equipsound = 'sound/f13weapons/equipsounds/laerequip.ogg'
	ammo_type = list(/obj/item/ammo_casing/energy/laser/laer)
	cell_type = /obj/item/stock_parts/cell/ammo/mfc
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY

/obj/item/gun/energy/laser/aer14
	name = "\improper AER14 laser rifle"
	desc = "The AER14, a successor to the AER9 and AER12, was a prototype in development before the Great War. It features an orange trim and higher firepower at the cost of slower firing rate."
	icon_state = "aer14"
	item_state = "laser-rifle9"
	can_scope = TRUE
	scope_state = "AEP7_scope"
	scope_x_offset = 12
	scope_y_offset = 20
	fire_delay = 3.5
	equipsound = 'sound/f13weapons/equipsounds/aer14equip.ogg'
	ammo_type = list(/obj/item/ammo_casing/energy/laser/aer14)
	cell_type = /obj/item/stock_parts/cell/ammo/mfc
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY

/obj/item/gun/energy/laser/aer12
	name = "\improper AER12 laser rifle"
	desc = "The AER12, a successor to the AER9, is a cutting-edge state of the art laser rifle employed pre-war in specialty units, featuring green-beams and associated green-trim"
	icon_state = "aer12"
	item_state = "laser-rifle9"
	can_scope = TRUE
	scope_state = "AEP7_scope"
	scope_x_offset = 12
	scope_y_offset = 20
	fire_delay = 3.5
	equipsound = 'sound/f13weapons/equipsounds/tribeamequip.ogg'
	ammo_type = list(/obj/item/ammo_casing/energy/laser/aer12)
	cell_type = /obj/item/stock_parts/cell/ammo/mfc
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY

/obj/item/gun/energy/gammagun
	name = "Gamma gun"
	desc = "A very crude weapon overall and appears to have been built from scavenged junk found throughout the wasteland."
	icon_state = "gammagun"
	item_state = "gammagun"
	ammo_type = list(/obj/item/ammo_casing/energy/gammagun)
	cell_type = /obj/item/stock_parts/cell/ammo/mfc
	ammo_x_offset = 3
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT

/obj/item/gun/energy/laser/wattz2k
	name = "wattz 2000"
	desc = "Wattz 2000 Laser Rifle. Uses micro fusion cells for more powerful lasers, and an extended barrel for additional range."
	icon_state = "wattz2k"
	item_state = "sniper_rifle"
	fire_delay = 3.5
	equipsound = 'sound/f13weapons/equipsounds/aer14equip.ogg'
	ammo_type = list(/obj/item/ammo_casing/energy/wattz2k)
	cell_type = /obj/item/stock_parts/cell/ammo/mfc
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	zoomable = TRUE
	zoom_amt = 10
	zoom_out_amt = 13

/obj/item/gun/energy/laser/wattz2k/extended
	name = "wattz 2000e"
	desc = "This Wattz 2000 laser rifle has had its recharging system upgraded and a special recycling chip installed that reduces the drain on the micro fusion cell by 50%."
	icon_state = "wattz2k_ext"
	ammo_type = list(/obj/item/ammo_casing/energy/wattz2k/extended)

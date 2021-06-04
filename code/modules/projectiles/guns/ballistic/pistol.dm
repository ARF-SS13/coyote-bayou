/obj/item/gun/ballistic/automatic/pistol
	slowdown = 0.1
	name = "stechkin pistol"
	desc = "A small, easily concealable 10mm handgun. Has a threaded barrel for suppressors."
	icon_state = "pistol"
	w_class = WEIGHT_CLASS_SMALL
	mag_type = /obj/item/ammo_box/magazine/m10mm
	can_suppress = TRUE
	burst_size = 1
	fire_delay = 0
	automatic_burst_overlay = FALSE
	slot_flags = ITEM_SLOT_BELT
	equipsound = 'sound/f13weapons/equipsounds/pistolequip.ogg'
	semi_auto = TRUE

/obj/item/gun/ballistic/automatic/pistol/no_mag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/automatic/pistol/update_icon_state()
	icon_state = "[initial(icon_state)][chambered ? "" : "-e"]"

/obj/item/gun/ballistic/automatic/pistol/suppressed/Initialize(mapload)
	. = ..()
	var/obj/item/suppressor/S = new(src)
	install_suppressor(S)

//(reskinnable stetchkin)
/obj/item/gun/ballistic/automatic/pistol/modular
	name = "modular pistol"
	desc = "A small, easily concealable 10mm handgun. Has a threaded barrel for suppressors."
	icon = 'modular_citadel/icons/obj/guns/cit_guns.dmi'
	icon_state = "cde"
	can_unsuppress = TRUE
	automatic_burst_overlay = FALSE
	obj_flags = UNIQUE_RENAME
	unique_reskin = list("Default" = "cde",
						"N-99" = "n99",
						"Stealth" = "stealthpistol",
						"HKVP-78" = "vp78",
						"Luger" = "p08b",
						"Mk.58" = "secguncomp",
						"PX4 Storm" = "px4"
						)

/obj/item/gun/ballistic/automatic/pistol/modular/update_icon_state()
	if(current_skin)
		icon_state = "[unique_reskin[current_skin]][chambered ? "" : "-e"][suppressed ? "-suppressed" : ""]"
	else
		icon_state = "[initial(icon_state)][chambered ? "" : "-e"][suppressed ? "-suppressed" : ""]"

/obj/item/gun/ballistic/automatic/pistol/modular/update_overlays()
	. = ..()
	if(magazine && suppressed)
		. += "[unique_reskin[current_skin]]-magazine-sup"	//Yes, this means the default iconstate can't have a magazine overlay
	else if (magazine)
		. += "[unique_reskin[current_skin]]-magazine"

/obj/item/gun/ballistic/automatic/pistol/m1911
	name = "m1911"
	desc = "A classic .45 handgun with a small magazine capacity."
	icon_state = "m1911"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/m45
	can_suppress = TRUE
	extra_damage = 5
	fire_delay = 2
	can_attachments = TRUE
	suppressor_state = "pistol_suppressor"
	suppressor_x_offset = 30
	suppressor_y_offset = 21

/obj/item/gun/ballistic/automatic/pistol/m1911/custom
	name = "\improper M1911 Custom"
	desc = "A well-maintained stainless-steel frame 1911, with genuine wooden grips."
	icon_state = "m1911_custom"
	fire_delay = 1
	extra_damage = 3

/obj/item/gun/ballistic/automatic/pistol/m1911/compact
	name = "m1911 compact"
	desc = "The compact version of the classic .45 handgun."
	icon_state = "c1911"
	w_class = WEIGHT_CLASS_SMALL
	extra_damage = 4
	suppressor_x_offset = 29
	suppressor_y_offset = 21

/obj/item/gun/ballistic/automatic/pistol/m1911/no_mag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/automatic/pistol/m1911/kitchengun
	name = "\improper Kitchen Gun (TM)"
	desc = "Say goodbye to dirt with Kitchen Gun (TM)! Laser sight and night vision accessories sold separately."
	icon_state = "kitchengun"
	mag_type = /obj/item/ammo_box/magazine/m45/kitchengun

/obj/item/gun/ballistic/automatic/pistol/deagle
	name = "\improper Desert Eagle"
	desc = "A robust .44 magnum semi-automatic handgun."
	icon_state = "deagle"
	force = 14
	extra_damage = 7
	extra_speed = 500
	mag_type = /obj/item/ammo_box/magazine/m44
	can_suppress = FALSE
	automatic_burst_overlay = FALSE
	fire_sound = 'sound/f13weapons/deagle.ogg'

/obj/item/gun/ballistic/automatic/pistol/deagle/update_overlays()
	. = ..()
	if(magazine)
		. += "deagle_magazine"

/obj/item/gun/ballistic/automatic/pistol/deagle/update_icon_state()
	icon_state = "[initial(icon_state)][chambered ? "" : "-e"]"

/obj/item/gun/ballistic/automatic/pistol/deagle/gold
	desc = "A gold plated Desert Eagle folded over a million times by superior martian gunsmiths. Uses .50 AE ammo."
	icon_state = "deagleg"
	item_state = "deagleg"

/obj/item/gun/ballistic/automatic/pistol/deagle/camo
	desc = "A Deagle brand Deagle for operators operating operationally. Uses .50 AE ammo."
	icon_state = "deaglecamo"
	item_state = "deagleg"

/obj/item/gun/ballistic/automatic/pistol/APS
	name = "stechkin APS pistol"
	desc = "The original Russian version of a widely used Syndicate sidearm. Uses 9mm ammo."
	icon_state = "aps"
	w_class = WEIGHT_CLASS_SMALL
	mag_type = /obj/item/ammo_box/magazine/pistolm9mm
	can_suppress = FALSE
	burst_size = 3
	fire_delay = 2
	actions_types = list(/datum/action/item_action/toggle_firemode)

/obj/item/gun/ballistic/automatic/pistol/stickman
	name = "flat gun"
	desc = "A 2 dimensional gun.. what?"
	can_suppress = FALSE
	icon_state = "flatgun"

/obj/item/gun/ballistic/automatic/pistol/stickman/pickup(mob/living/user)
	. = ..()
	to_chat(user, "<span class='notice'>As you try to pick up [src], it slips out of your grip..</span>")
	if(prob(50))
		to_chat(user, "<span class='notice'>..and vanishes from your vision! Where the hell did it go?</span>")
		qdel(src)
		user.update_icons()
	else
		to_chat(user, "<span class='notice'>..and falls into view. Whew, that was a close one.</span>")
		user.dropItemToGround(src)

////////////Anti Tank Pistol////////////

/obj/item/gun/ballistic/automatic/pistol/antitank
	name = "Anti Tank Pistol"
	desc = "A massively impractical and silly monstrosity of a pistol that fires .50 calliber rounds. The recoil is likely to dislocate your wrist."
	icon = 'modular_citadel/icons/obj/guns/cit_guns.dmi'
	icon_state = "atp"
	item_state = "pistol"
	recoil = 4
	mag_type = /obj/item/ammo_box/magazine/sniper_rounds
	fire_delay = 50
	burst_size = 1
	can_suppress = 0
	w_class = WEIGHT_CLASS_NORMAL
	fire_sound = 'sound/weapons/blastcannon.ogg'
	spread = 20		//damn thing has no rifling.
	automatic_burst_overlay = FALSE

/obj/item/gun/ballistic/automatic/pistol/antitank/update_overlays()
	. = ..()
	if(magazine)
		. += "atp-mag"

/obj/item/gun/ballistic/automatic/pistol/antitank/update_icon_state()
	icon_state = "[initial(icon_state)][chambered ? "" : "-e"]"

/obj/item/gun/ballistic/automatic/pistol/antitank/syndicate
	name = "Syndicate Anti Tank Pistol"
	desc = "A massively impractical and silly monstrosity of a pistol that fires .50 calliber rounds. The recoil is likely to dislocate a variety of joints without proper bracing."
	pin = /obj/item/firing_pin/implant/pindicate

/obj/item/gun/ballistic/automatic/pistol/n99
	name = "10mm pistol"
	desc = "A pre-war large-framed, gas-operated advanced 10mm pistol."
	icon_state = "n99"
	mag_type = /obj/item/ammo_box/magazine/m10mm_adv/simple
	fire_sound = 'sound/f13weapons/10mm_fire_02.ogg'
	w_class = WEIGHT_CLASS_NORMAL
	can_attachments = TRUE
	fire_delay = 2
	can_suppress = TRUE
	can_automatic = TRUE
	suppressor_state = "n99_suppressor"
	suppressor_x_offset = 29
	suppressor_y_offset = 15

/obj/item/gun/ballistic/automatic/pistol/n99/executive
	name = "\improper Executive" //'the Executive'
	desc = "A gas-operated N99 pistol chambered in 10mm rounds. It has an accurate two-round-burst and a blue Vault-Tec finish, for only the most robust overseers."
	icon_state = "executive"
	can_suppress = TRUE
	burst_size = 2
	can_automatic = FALSE
	extra_penetration = 0.2 //2x 35 damage, 10 AP- hits like a 2rd burst 5.56, but more accurate
	semi_auto = FALSE

/obj/item/gun/ballistic/automatic/pistol/ninemil
	name = "browning hi-power"
	desc = "A mass produced pre-war Browning Hi-power 9mm pistol."
	icon_state = "ninemil"
	mag_type = /obj/item/ammo_box/magazine/m9mm
	w_class = WEIGHT_CLASS_NORMAL
	fire_delay = 2
	can_suppress = TRUE
	fire_sound = 'sound/f13weapons/ninemil.ogg'
	can_attachments = TRUE
	suppressor_state = "pistol_suppressor"
	suppressor_x_offset = 30
	suppressor_y_offset = 19

/obj/item/gun/ballistic/automatic/pistol/beretta
	name = "beretta M9FS"
	desc = "One of the more common 9mm pistols, the Beretta is popular due to its reliability, 15 round magazine and good looks."
	icon_state = "beretta"
	mag_type = /obj/item/ammo_box/magazine/m9mmds
	w_class = WEIGHT_CLASS_NORMAL
	fire_delay = 2
	can_suppress = FALSE
	fire_sound = 'sound/f13weapons/9mm.ogg'
	can_attachments = TRUE
	extra_damage = 3
	can_suppress = "pistol_suppressor"
	suppressor_x_offset = 30
	suppressor_y_offset = 20

/obj/item/gun/ballistic/automatic/pistol/beretta/automatic
	name = "beretta M93R"
	desc = "A rare select fire variant of the M93R."
	icon_state = "m93r"
	burst_size = 3
	actions_types = list(/datum/action/item_action/toggle_firemode)
	automatic_burst_overlay = TRUE
	can_attachments = FALSE
	semi_auto = FALSE

/obj/item/gun/ballistic/automatic/pistol/sig
	name = "sig p220"
	desc = "The P220 Sig Sauer. A Swiss designed pistol, the Sig Sauer benefits from compact and lightweight construction."
	icon_state = "sig"
	mag_type = /obj/item/ammo_box/magazine/m9mm
	w_class = WEIGHT_CLASS_SMALL
	fire_delay = 0
	can_suppress = TRUE
	fire_sound = 'sound/f13weapons/ninemil.ogg'
	can_attachments = TRUE
	extra_damage = 2
	suppressor_state = "pistol_suppressor"
	suppressor_x_offset = 30
	suppressor_y_offset = 20

/obj/item/gun/ballistic/automatic/pistol/ninemil/maria
	name = "Maria"
	desc = "An ornately-decorated pre-war Browning Hi-power 9mm pistol with pearl grips and a polished nickel finish. The firing mechanism has been upgraded, so for anyone on the receiving end, it must seem like an eighteen-karat run of bad luck."
	icon_state = "maria"
	w_class = WEIGHT_CLASS_SMALL
	fire_delay = 0
	extra_damage = 10 //40 damage, 20 AP- hits like a 7.62 and fires faster
	extra_penetration = 0.3

/obj/item/gun/ballistic/automatic/pistol/type17
	name = "type 17"
	desc = "A reproduction of the WW2 weapon and issued to the Chinese military at the time of the Great War. Most samples seen are surplus finds from the time of the Great War. Chambered in 9mm."
	icon_state = "c96"
	mag_type = /obj/item/ammo_box/magazine/m9mm
	fire_delay = 1
	can_suppress = FALSE
	fire_sound = 'sound/f13weapons/ninemil.ogg'

/obj/item/gun/ballistic/automatic/pistol/pistol127
	name = "12.7mm pistol"
	desc = "A Swiss SIG-Sauer 14mm handgun rechambered for 12.7mm ammunition, likely designed for long-range pistol hunting or target shooting."
	icon_state = "pistol127"
	force = 14
	mag_type = /obj/item/ammo_box/magazine/m127mm
	fire_delay = 4
	can_suppress = TRUE
	fire_sound = 'sound/f13weapons/magnum_fire.ogg'
	suppressor_x_offset = 30
	suppressor_y_offset = 19
	suppressor_state = "n99_suppressor"

/obj/item/gun/ballistic/automatic/pistol/pistol127/compact
	name = "compact 12.7mm pistol"
	desc = "A Swiss SIG-Sauer 14mm handgun rechambered for 12.7mm ammunition, likely designed for long-range pistol hunting or target shooting. This one is a compact model for concealed carry."
	icon_state = "pistol127_compact"
	w_class = WEIGHT_CLASS_SMALL
	extra_damage = -3 //Smaller barrel, smaller bullet velocity
	extra_penetration = -0.06 //See above
	spread = 3
	suppressor_x_offset = 28
	suppressor_y_offset = 19

/obj/item/gun/ballistic/automatic/pistol/pistol127/lildevil
	name= "\improper tactical 12.7mm pistol"
	desc = "A Swiss SIG-Sauer 14mm handgun rechambered for 12.7mm ammunition, likely designed for long-range pistol hunting or target shooting. A finely tuned firearm from the Gunrunners."
	icon_state = "lildev"
	w_class = WEIGHT_CLASS_SMALL
	fire_delay = 2
	extra_damage = 8
	extra_penetration = 0.15
	suppressor_x_offset = 28
	suppressor_y_offset = 19

/obj/item/gun/ballistic/automatic/pistol/pistol22
	name = ".22 pistol"
	desc = "The silenced .22 pistol is a .22LR round handgun with an integrated silencer."
	icon_state = "silenced22"
	mag_type = /obj/item/ammo_box/magazine/m22
	w_class = WEIGHT_CLASS_SMALL
	fire_delay = 0
	can_suppress = FALSE
	can_unsuppress = FALSE
	suppressed = 1
	fire_sound = 'sound/f13weapons/22pistol.ogg'
	can_attachments = TRUE

/obj/item/gun/ballistic/automatic/pistol/mk23
	name = "\improper mk23"
	desc = "A sleek looking handgun chambered in .45 ACP for all your operating needs."
	icon_state = "mk23"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/m45exp
	fire_sound = 'sound/weapons/Gunshot_smg.ogg'
	fire_delay = 1
	extra_damage = 7
	extra_penetration = 0.3
	can_suppress = TRUE
	suppressor_state = "pistol_suppressor"
	suppressor_x_offset = 28
	suppressor_y_offset = 20

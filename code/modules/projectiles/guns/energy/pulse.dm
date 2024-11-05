/obj/item/gun/energy/pulse
	name = "pulse rifle"
	desc = "A heavy-duty, multifaceted energy rifle with three modes. Preferred by front-line combat personnel."
	icon_state = "pulse"
	inhand_icon_state = null
	modifystate = TRUE
	flags_1 =  CONDUCT_1
	ammo_type = list(/obj/item/ammo_casing/energy/laser/pulse, /obj/item/ammo_casing/energy/electrode, /obj/item/ammo_casing/energy/laser)
	cell_type = "/obj/item/stock_parts/cell/pulse"
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY

/obj/item/gun/energy/pulse/emp_act(severity)
	return

/obj/item/gun/energy/pulse/prize
	pin = /obj/item/firing_pin

/obj/item/gun/energy/pulse/prize/Initialize()
	. = ..()
	GLOB.poi_list += src
	var/turf/T = get_turf(src)
	var/msg = "A pulse rifle prize has been created at [ADMIN_VERBOSEJMP(T)]"

	message_admins(msg)
	log_game(msg)

	notify_ghosts("Someone won a pulse rifle as a prize!", source = src, action = NOTIFY_ORBIT)

/obj/item/gun/energy/pulse/prize/Destroy()
	GLOB.poi_list -= src
	. = ..()

/obj/item/gun/energy/pulse/loyalpin
	pin = /obj/item/firing_pin/implant/mindshield

/obj/item/gun/energy/pulse/carbine
	name = "pulse carbine"
	desc = "A compact variant of the pulse rifle with less firepower but easier storage."
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_TWO_HAND_ONLY
	icon_state = "pulse_carbine"
	inhand_icon_state = null
	cell_type = "/obj/item/stock_parts/cell/pulse/carbine"
	can_flashlight = 1
	flight_x_offset = 18
	flight_y_offset = 12

/obj/item/gun/energy/pulse/carbine/loyalpin
	pin = /obj/item/firing_pin/implant/mindshield

/obj/item/gun/energy/pulse/pistol
	name = "pulse pistol"
	desc = "A pulse rifle in an easily concealed handgun package with low capacity."
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_TWO_HAND_ONLY
	icon_state = "pulse_pistol"
	inhand_icon_state = "gun"
	cell_type = "/obj/item/stock_parts/cell/pulse/pistol"

/obj/item/gun/energy/pulse/pistol/loyalpin
	pin = /obj/item/firing_pin/implant/mindshield

/obj/item/gun/energy/pulse/destroyer
	name = "pulse destroyer"
	desc = "A heavy-duty energy rifle built for pure destruction."
	cell_type = "/obj/item/stock_parts/cell/infinite"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/pulse)

/obj/item/gun/energy/pulse/destroyer/attack_self(mob/living/user)
	to_chat(user, span_danger("[src.name] has three settings, and they are all DESTROY."))

/obj/item/gun/energy/pulse/pistol/m1911
	name = "\improper M1911-P"
	desc = "A compact pulse core in a classic handgun frame for US Government officers. It's not the size of the gun, it's the size of the hole it puts through people."
	icon_state = "m1911"
	inhand_icon_state = "gun"
	cell_type = "/obj/item/stock_parts/cell/infinite"

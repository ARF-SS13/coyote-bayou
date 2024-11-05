//Tesla Cannon
/obj/item/gun/energy/tesla/teslacannon
	name = "Tesla Cannon"
	desc = "A shoulder-mounted energy weapon that is powered by electron charge packs that discharges a large electrical impulse upon impact with a much larger area of effect. "
	icon_state = "lasercannon"
	inhand_icon_state = "laser"
	ammo_type = list(/obj/item/ammo_casing/energy/tesla/teslacannon)
	cell_type = /obj/item/stock_parts/cell/ammo/ecp
	fire_delay = 13
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	equipsound = 'sound/f13weapons/equipsounds/aer14equip.ogg'

	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)

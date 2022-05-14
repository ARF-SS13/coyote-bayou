/obj/item/projectile/energy/tesla
	name = "tesla bolt"
	icon_state = "tesla_projectile"
	impact_effect_type = /obj/effect/temp_visual/impact_effect/blue_laser
	var/chain
	var/zap_flags = ZAP_MOB_DAMAGE | ZAP_OBJ_DAMAGE
	var/zap_range = 3
	var/power = 10000

/obj/item/projectile/energy/tesla/fire(setAngle, atom/direct_target)
	var/atom/source = fired_from || firer
	if(source)
		chain = source.Beam(src, icon_state = "lightning[rand(1, 12)]", time = INFINITY, maxdistance = INFINITY)
	return ..()

/obj/item/projectile/energy/tesla/on_hit(atom/target)
	. = ..()
	tesla_zap(target, zap_range, power, zap_flags)
	qdel(src)

/obj/item/projectile/energy/tesla/Destroy()
	qdel(chain)
	return ..()

/obj/item/projectile/energy/tesla/revolver
	name = "energy orb"

/obj/item/projectile/energy/tesla/cannon
	name = "tesla orb"
	power = 20000

/obj/item/projectile/energy/teslacannon
	name = "tesla beam"
	icon_state = "omnilaser"
	impact_effect_type = /obj/effect/temp_visual/impact_effect/blue_laser
	light_color = LIGHT_COLOR_BLUE
	damage = 55
	armour_penetration = 0.35
	wound_bonus = 30
	tracer_type = /obj/effect/projectile/tracer/pulse
	muzzle_type = /obj/effect/projectile/muzzle/pulse
	impact_type = /obj/effect/projectile/impact/pulse
	hitscan = TRUE
	hitscan_light_intensity = 4
	hitscan_light_range = 1
	hitscan_light_color_override = LIGHT_COLOR_BLUE
	muzzle_flash_intensity = 9
	muzzle_flash_range = 4
	muzzle_flash_color_override = LIGHT_COLOR_BLUE
	impact_light_intensity = 8
	impact_light_range = 3.75
	impact_light_color_override = LIGHT_COLOR_BLUE

/obj/item/projectile/energy/teslacannon/oasis
	name = "shock beam"
	damage = 8
	armour_penetration = 0
	stamina = 10
	flag = "energy"
	wound_bonus = -10
	bare_wound_bonus = 30

/obj/item/projectile/energy/teslacannon/oasis/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(!ismob(target) || blocked >= 100) //Fully blocked by mob or collided with dense object - burst into sparks!
		do_sparks(1, TRUE, src)

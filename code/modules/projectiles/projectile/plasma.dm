/obj/item/projectile/energy/plasmabolt
	name = "plasma bolt"
	icon_state = "plasma"
	flag = "energy"
	damage_type = BURN
	hitsound = 'sound/weapons/sear.ogg'
	hitsound_wall = 'sound/weapons/effects/searwall.ogg'
	light_range = 3
	light_color = LIGHT_COLOR_GREEN
	recoil = BULLET_RECOIL_PLASMA
	sharpness = SHARP_POINTY // Temporary fix for the Wound system. Makes lasers/plasma bleed you out per hit.

/obj/item/projectile/energy/plasmabolt/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(isturf(target) || istype(target, /obj/structure/))
		target.ex_act(EXPLODE_LIGHT)

/obj/item/projectile/energy/plasmabolt/eve
	name = "eve bolt"
	icon = 'icons/fallout/objects/guns/projectiles.dmi'
	icon_state = "eve"
	flag = "energy"
	damage_type = BURN
	hitsound = 'sound/weapons/sear.ogg'
	hitsound_wall = 'sound/weapons/effects/searwall.ogg'
	light_range = 5
	light_color = LIGHT_COLOR_PINK

/obj/item/projectile/energy/plasmabolt/eve/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(isturf(target) || istype(target, /obj/structure/))
		target.ex_act(EXPLODE_LIGHT)


/obj/item/projectile/energy/plasmabolt/light
	damage = 30
	icon_state = "plasma2"
	irradiate = 10
	stamina = 20

/obj/item/projectile/energy/plasmabolt/rifle
	damage = 50
	icon_state = "plasma3"
	irradiate = 35
	stamina = 120

/obj/item/projectile/energy/plasmabolt/MP40k
	damage = 35
	eyeblur = 4
	irradiate = 25
	stamina = 100
	icon_state = "plasma3"

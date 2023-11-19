/obj/item/projectile/energy/bolt //ebow bolts
	flag = "energy"
	name = "bolt"
	icon_state = "cbbolt"
	damage = 30
	damage_list = list( "25" = 20, "30" = 60, "35" = 15, "60" = 5)
	damage_type = BURN
	nodamage = 0
	eyeblur = 10
	slur = 5
	stamina = 60
//	knockdown = 160
//	knockdown_stamoverride = 0

/obj/item/projectile/energy/bolt/halloween
	name = "candy corn"
	icon_state = "candy_corn"

/obj/item/projectile/energy/bolt/large
	damage = 60
	damage_list = list( "50" = 20, "60" = 64, "75" = 15, "90" = 1)

/obj/item/projectile/energy/bolt/rock
	damage = 30
	damage_list = list( "25" = 20, "30" = 64, "35" = 15, "45" = 1)
	damage_type = BRUTE
	flag = "bullet"
	sharpness = SHARP_POINTY
	eyeblur = 0
	slur = 0
	stamina = 40
	name = "rock"
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "rock"

/obj/item/projectile/energy/bolt/smooch // fucking cursed
	name = "smooch"
	icon_state = "love"
	damage = 0
	damage_list = null
	damage_type = OXY
	nodamage = 1
	eyeblur = 0
	slur = 0
	stamina = 0
	hitsound = 'sound/effects/kiss.ogg'
	hitsound_wall = 'sound/effects/kiss.ogg'

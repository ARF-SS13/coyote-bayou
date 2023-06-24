/obj/item/projectile/beam/ten
	name = "light laser bolt"
	damage = 10
	icon_state = "red_laser"
	impact_effect_type = /obj/effect/temp_visual/impact_effect/red_laser
	light_color = LIGHT_COLOR_RED

/obj/item/projectile/beam/ten/hitscan // cumbeam
	name = "light laser beam"
	damage = 10*0.8 //can make these be defines laters
	hitscan = TRUE
	tracer_type = /obj/effect/projectile/tracer/twin_laser
	muzzle_type = /obj/effect/projectile/muzzle/twin_laser
	impact_type = /obj/effect/projectile/impact/twin_laser

/obj/item/projectile/beam/fifteen
	name = "yellow laser bolt"
	damage = 15
	icon_state = "stunjectile"
	impact_effect_type = /obj/effect/temp_visual/impact_effect/yellow_laser
	light_color = LIGHT_COLOR_YELLOW

/obj/item/projectile/beam/fifteen/hitscan
	name = "yellow laser beam"
	damage = 15*0.8
	hitscan = TRUE
	tracer_type = /obj/effect/projectile/tracer/stun
	muzzle_type = /obj/effect/projectile/muzzle/stun
	impact_type = /obj/effect/projectile/impact/stun

/obj/item/projectile/beam/twenty
	name = "blue laser bolt"
	damage = 20
	icon_state = "u_laser"
	impact_effect_type = /obj/effect/temp_visual/impact_effect/blue_laser
	light_color = LIGHT_COLOR_BLUE

/obj/item/projectile/beam/twenty/hitscan
	name = "blue laser beam"
	damage = 20*0.8
	hitscan = TRUE
	tracer_type = /obj/effect/projectile/tracer/laser/blue
	muzzle_type = /obj/effect/projectile/muzzle/laser/blue
	impact_type = /obj/effect/projectile/impact/laser/blue

/obj/item/projectile/beam/twentyfive
	name = "green laser bolt"
	damage = 25
	icon_state = "xray"
	impact_effect_type = /obj/effect/temp_visual/impact_effect/green_laser
	light_color = LIGHT_COLOR_GREEN

/obj/item/projectile/beam/twentyfive/hitscan
	name = "green laser beam"
	damage = 25*0.8
	hitscan = TRUE
	tracer_type = /obj/effect/projectile/tracer/xray
	muzzle_type = /obj/effect/projectile/muzzle/xray
	impact_type = /obj/effect/projectile/impact/xray

/obj/item/projectile/beam/thirty
	name = "red laser bolt"
	damage = 30
	icon_state = "bolt"
	impact_effect_type = /obj/effect/temp_visual/impact_effect/red_laser
	light_color = LIGHT_COLOR_RED

/obj/item/projectile/beam/thirty/hitscan
	name = "red laser beam"
	damage = 30*0.8
	hitscan = TRUE
	tracer_type = /obj/effect/projectile/tracer/laser
	muzzle_type = /obj/effect/projectile/muzzle/laser
	impact_type = /obj/effect/projectile/impact/laser

/obj/item/projectile/beam/fifty
	name = "green plasma bolt"
	damage = 50
	icon_state = "plasma_clot"
	impact_effect_type = /obj/effect/temp_visual/impact_effect/green_laser
	light_color = LIGHT_COLOR_GREEN

/obj/item/projectile/beam/fifty/hitscan
	name = "green plasma stream"
	damage = 50*0.8
	hitscan = TRUE
	tracer_type = /obj/effect/projectile/tracer/plasma
	muzzle_type = /obj/effect/projectile/muzzle/plasma
	impact_type = /obj/effect/projectile/impact/plasma

/obj/item/projectile/beam/sixty
	name = "red plasma bolt"
	damage = 60
	icon_state = "plasma_red"
	impact_effect_type = /obj/effect/temp_visual/impact_effect/red_laser
	light_color = LIGHT_COLOR_RED

/obj/item/projectile/beam/sixty/hitscan
	name = "red plasma stream"
	damage = 60*0.8
	hitscan = TRUE
	tracer_type = /obj/effect/projectile/tracer/purple_laser
	muzzle_type = /obj/effect/projectile/muzzle/purple_laser
	impact_type = /obj/effect/projectile/impact/purple_laser
